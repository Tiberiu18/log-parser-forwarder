import React, { useEffect, useState } from 'react';
import { getLogs } from '../services/api.js';

function LogViewer() {
  const [logs, setLogs] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    getLogs()
      .then(data => {
	      console.log('Received logs', data.logs);
	      setLogs(data.logs);
      })
      .catch(err => setError(err.message));
  }, []);

  return (
    <div>
      <h2>Logs</h2>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      <ul>
        {logs.map((log, index) => (
          <li key={index}>{log.content}</li>
        ))}
      </ul>
    </div>
  );
}

export default LogViewer;

