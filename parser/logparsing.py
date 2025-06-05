import requests
import json
import argparse
import re
def readLogFile(filename):
    with open(filename,"r") as logf:
        content = logf.read()
        return content

def createListFromContent(content):
    #Split lines with newline as separator
    listOfLines=re.split(r'[\n]', content)
    return listOfLines

def filterLinesForError(listOfLines):
    filtered_lines = []
    for line in listOfLines:
        if "critical" in line.lower() or "error" in line.lower():
            filtered_lines.append(line)
    listOfLines.clear()
    return filtered_lines



def createBatchesOfTen(content):
    listOfLines_raw=createListFromContent(content)
    listOfLines_filtered = filterLinesForError(listOfLines_raw)
    listOfBatches = []
    count = 0
    batch=[]
    for line in listOfLines_filtered:
        batch.append(line)
        count=count+1
        if count == 10:
            listOfBatches.append(batch.copy())
            batch.clear()
            count = 0
    # Means the last batch will have a length lesser than 10, we do not want to skip these
    if len(batch) > 0:
        listOfBatches.append(batch.copy())
        batch.clear()
    return listOfBatches

def sendBatch(URL,listOfBatches):
    payload = {"logs": listOfBatches}
    print(payload)
    headers = {'Content-Type':'application/json'}
    response = requests.post(URL, json=payload, headers=headers)
    if response.status_code == 200:
        print("Batch sent successfully.")
    else:
        print("Batch failed to be sent. Error status code is: ", response.status_code)
    return response

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Log parsing and forwarding")
    parser.add_argument("logfile")
    arguments = parser.parse_args()
    logfile = arguments.logfile
    logfile_content = readLogFile(logfile)
    listOfBatches=createBatchesOfTen(logfile_content)
    URL = "http://log-receiver-api:3000/logs"
    response = sendBatch(URL,listOfBatches)
    print(response.text)
