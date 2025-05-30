FROM python:latest

LABEL Maintainer="Tiberiu18"

WORKDIR /usr/app/src

COPY logparsing.py ./

COPY sample.log ./

COPY createSampleLogFile.py ./

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "./logparsing.py", "./sample.log"]
