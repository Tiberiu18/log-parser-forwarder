#🟦 1. Log Parser în Python
#Scop: Script care:

#Citește fișierul de log (app.log).

#Filtrează doar liniile ce conțin „ERROR” sau „CRITICAL”.

#Le împarte în grupuri de câte 10.

#Le trimite către un endpoint /logs.

#Tehnologii: Python + requests + json

#📝 Pași:

#Creează scriptul de citire și filtrare.

#Creează o funcție care împarte lista în batch-uri.

#Creează o funcție care trimite un batch la API (POST request).

#Testează local cu un endpoint fals (ex: httpbin.org/post).

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


def createBatchesOfTen(content):
    listOfLines=createListFromContent(content)
    listOfBatches = []
    count = 0
    batch=[]
    for line in listOfLines:
        batch.append(line)
        count=count+1
        if count == 10:
            listOfBatches.append(batch.copy())
            batch.clear()
            count = 0
    return listOfBatches

#Creează o funcție care trimite un batch la API (POST request).
def sendBatch(URL,batch):
    payload = json.dumps(batch)
    print(payload)
    headers = {'Content-Type':'application/json'}
    response = requests.post(URL, data=payload, headers=headers)
    if response.status_code == 200:
        print("Batch-ul a fost trimis cu success")
    else:
        print("Batch-ul nu a reusit sa fie trimis. eroarea este ", response.status_code)
    return response

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Log parsing and forwarding")
    parser.add_argument("logfile")
    arguments = parser.parse_args()
    logfile = arguments.logfile
    logfile_content = readLogFile(logfile)
    listOfBatches=createBatchesOfTen(logfile_content)
    URL = "https://httpbin.org/post"
    response = sendBatch(URL,listOfBatches)
    print(response.text)