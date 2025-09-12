from flask import Flask, request, jsonify
import tempfile
import os
from core import readLogFile, createBatchesOfTen, sendBatch
from metrics import batches_sent, parser_errors
from flask_cors import CORS
from werkzeug.utils import secure_filename

app = Flask(__name__)
CORS(app)
URL = os.getenv("API_URL", "http://log-receiver-api:3000/logs")

@app.route('/upload-log', methods=['POST'])
def upload_log():
    try:
        print("📥 Incoming request to /upload-log")
        print("Headers:", dict(request.headers))
        print("Files received:", request.files)
        print("JSON body:", request.get_json(silent=True))

        if 'file' in request.files:
            print("➡️ File upload mode detected")
            log_file = request.files['file']
            original_name = secure_filename(log_file.filename)
            print(f"Original filename from client: {original_name}")

            save_path = os.path.join(tempfile.gettempdir(), original_name)
            print(f"Saving uploaded file to: {save_path}")
            log_file.save(save_path)

            logfile_content = readLogFile(save_path)
            print(f"Read {len(logfile_content)} lines from uploaded file")
            logFilePath = save_path

        elif request.is_json and 'content' in request.json:
            print("➡️ Raw JSON content mode detected")
            logfile_content = request.json['content']
            temp_path = tempfile.mktemp(suffix=".log")
            print(f"Saving JSON content to temp file: {temp_path}")
            with open(temp_path, 'w') as f:
                f.write(logfile_content)
            logFilePath = temp_path

        else:
            print("❌ No file or content provided in request")
            return jsonify({"error": "No log content or file provided"}), 400

        print("📦 Creating batches of 10 log entries...")
        listOfBatches = createBatchesOfTen(logfile_content)
        print(f"Generated {len(listOfBatches)} batches")

        print(f"🚀 Sending batches to {URL}")
        sendBatch(URL, listOfBatches, logFilePath)

        batches_sent.inc()
        print("✅ Processing complete, returning success")
        return jsonify({"status": "success"})

    except Exception as exc:
        parser_errors.inc()
        print("💥 Exception occurred in upload_log:", str(exc))
        return jsonify({"error": str(exc)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3092, debug=True)

