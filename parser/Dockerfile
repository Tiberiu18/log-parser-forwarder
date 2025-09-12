FROM python:latest

LABEL Maintainer="Tiberiu18"

WORKDIR /usr/app/src

COPY . ./ 

RUN python -m venv /venv

ENV PATH="/venv/bin/:$PATH"

RUN pip install --no-cache-dir -r requirements.txt

# Expose API PORT
EXPOSE 5000

# MODE variable decides which mode to run in 
# MODE=cli -> start main.py
# Mode = API -> start server.py
ENV LOGFILE="./sample.log"

CMD if [ "$MODE" = "api" ]; then \
	python -m server;
   else \
	python -m main "$LOGFILE"; \
fi
