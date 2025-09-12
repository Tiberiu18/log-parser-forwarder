from prometheus_client import Counter, start_http_server

batches_sent = Counter("batches_sent_total", "Log batches successfully sent")
parser_errors = Counter("parser_errors_total", "Errors encountered by the parser")

def start_metrics_server(port=8000):
    start_http_server(port)
    print(f"[INIT] Metrics server running on :{port}")

