from datetime import datetime
import random

levels = ["INFO", "ERROR", "WARN", "DEBUG"]

def generate_log_line():
    ts = datetime.utcnow().isoformat()
    level = random.choice(levels)
    msg = f"Sample log message with level {level}"
    return f"[{ts}] {level}: {msg}"

with open("sample.log", "w") as f:
    for _ in range(50):
        f.write(generate_log_line() + "\n")

print("Sample log file created: sample.log")

