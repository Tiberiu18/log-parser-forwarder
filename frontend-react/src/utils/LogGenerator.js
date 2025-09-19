// src/utils/logGenerator.js

export function generateLogContent() {
  const entries = [
    { level: 'INFO', message: 'Starting log generation' },
    { level: 'ERROR', message: 'Failed to connect to database' },
    { level: 'INFO', message: 'Retrying connection' },
    { level: 'ERROR', message: 'Timeout while fetching data' },
    { level: 'INFO', message: 'Connection established' },
    { level: 'ERROR', message: 'Unexpected token in JSON' },
    { level: 'INFO', message: 'Log generation complete' }
  ];

  const now = new Date().toISOString();

  const logArray = entries.map(entry => [
    now,
    entry.level,
    entry.message
  ]);

  return logArray;
}

export function downloadLogFile(logArray, filename) {

  const content = logArray
    .map(([timestamp, level, message]) => `[${timestamp}] ${level}: ${message}`)
    .join('\n');

  const blob = new Blob([content], { type: 'text/plain' });
  const url = URL.createObjectURL(blob);

  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  a.click();

  URL.revokeObjectURL(url);
}

