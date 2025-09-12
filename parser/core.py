import os
import re
from datetime import datetime
import requests

def readLogFile(filename):
    with open(filename, "r") as logf:
        return logf.read()

def createListFromContent(content):
    return re.split(r'[\n]', content)

def filterLinesForError(listOfLines):
    return [line for line in listOfLines if "critical" in line.lower() or "error" in line.lower()]

def createBatchesOfTen(content):
    listOfLines_raw = createListFromContent(content)
    listOfLines_filtered = filterLinesForError(listOfLines_raw)
    batches, batch = [], []
    for line in listOfLines_filtered:
        batch.append(line)
        if len(batch) == 10:
            batches.append(batch.copy())
            batch.clear()
    if batch:
        batches.append(batch.copy())
    return batches

def sendBatch(URL, listOfBatches, logFilePath, headers_extra=None):
    logFileName = os.path.basename(logFilePath)
    mod_time = os.path.getmtime(logFilePath)
    mod_timestamp = datetime.utcfromtimestamp(mod_time).isoformat()

    headers = {
        'Content-Type': 'application/json',
        'X-Log-File-Name': logFileName,
        'X-Log-Timestamp': mod_timestamp
    }
    if headers_extra:
        headers.update(headers_extra)

    payload = {"logs": listOfBatches}
    response = requests.post(URL, json=payload, headers=headers, timeout=5)
    response.raise_for_status()
    return response
