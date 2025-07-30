FROM python:latest

LABEL Maintainer="Tiberiu18"

WORKDIR /usr/app/src

COPY logparsing.py ./

COPY logparsing_for_testing.py ./

COPY sample.log ./

COPY createSampleLogFile.py ./

COPY requirements.txt ./

RUN python -m venv /venv

ENV PATH="/venv/bin/:$PATH"

RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "./logparsing.py", "./sample.log"]
