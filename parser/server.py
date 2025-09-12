from flask import Flask, request, jsonify
import tempfile
from .core import readLogFile, createBatchesOfTen, sendBatch
from .metrics import batches_sent, parser_errors

import os

app = Flask(__name__)
URL = os.getenv("API_URL", "http://log-receiver-api:3000/logs")

@app.route('/upload-log', methods=['POST'])
def upload_log():
    try:
        if 'file' in request.files:
            log_file = request.files['file']
            temp_path = tempfile.mktemp(suffix=".log")
            log_file.save(temp_path)
            logfile_content = readLogFile(temp_path)
            logFilePath = temp_path
        elif request.is_json and 'content' in request.json:
            logfile_content = request.json['content']
            temp_path = tempfile.mktemp(suffix=".log")
            with open(temp_path, 'w') as f:
                f.write(logfile_content)
            logFilePath = temp_path
        else:
            return jsonify({"error": "No log content or file provided"}), 400

        listOfBatches = createBatchesOfTen(logfile_content)
        sendBatch(URL, listOfBatches, logFilePath)
        batches_sent.inc()
        return jsonify({"status": "success"})
    except Exception as exc:
        parser_errors.inc()
        return jsonify({"error": str(exc)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=6000)

