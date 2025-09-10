import React, { useEffect, useState } from 'react';
import { getLogs } from '../services/api.js';

function LogViewer() {
  const [logs, setLogs] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchLogs = () => {
    getLogs()
      .then(data => {
        console.log('Received logs', data.logs);
        setLogs(data.logs);
      })
      .catch(err => setError(err.message));
  };

  fetchLogs();
  const interval= setInterval(fetchLogs,10000);

  return () => clearInterval(interval);
}, []);

return (
    <div style={{ padding: '20px', fontFamily: 'Arial, sans-serif' }}>
      <h2>Last three logs</h2>
      {error && <p style={{ color: 'red' }}>Eroare: {error}</p>}
      <ul style={{ listStyle: 'none', padding: 0 }}>
        {logs.map((log, index) => (
          <li
            key={index}
            style={{
              marginBottom: '20px',
              padding: '15px',
              backgroundColor: '#f9f9f9',
              border: '1px solid #ddd',
              borderRadius: '8px',
            }}
          >
            <strong>🗂️ File:</strong> {log.file} <br />
            <strong>🕒 Time:</strong> {new Date(log.timestamp).toLocaleString()} <br />
            <strong>📄 Content:</strong>
            <pre
              style={{
                backgroundColor: '#eee',
                padding: '10px',
                borderRadius: '5px',
                overflowX: 'auto',
                marginTop: '10px',
              }}
            >
              {log.content}
            </pre>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default LogViewer;

