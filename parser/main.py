import argparse
import time
import os
from .core import readLogFile, createBatchesOfTen, sendBatch
from .metrics import start_metrics_server, batches_sent, parser_errors

def main():
    parser = argparse.ArgumentParser(description="Log parsing and forwarding")
    parser.add_argument("logfile")
    parser.add_argument("--once", action="store_true", help="Run only one parsing cycle")
    args = parser.parse_args()

    logfile = args.logfile
    run_once = args.once
    URL = os.getenv("API_URL", "http://log-receiver-api:3000/logs")

    start_metrics_server(8000)

    while True:
        try:
            logfile_content = readLogFile(logfile)
            listOfBatches = createBatchesOfTen(logfile_content)
            sendBatch(URL, listOfBatches, logfile)
            batches_sent.inc()
        except Exception as exc:
            parser_errors.inc()
            print("[MAIN] Unhandled error:", exc)
        if run_once:
            break
        time.sleep(60)

if __name__ == "__main__":
    main()

