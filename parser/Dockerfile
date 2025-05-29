FROM python:latest

LABEL Maintainer="Tiberiu18"

WORKDIR /usr/app/src

COPY logparsing.py ./

COPY sample.log ./

COPY createSampleLogFile.py ./

CMD [ "python", "./logparsing.py", "./sample.log"]