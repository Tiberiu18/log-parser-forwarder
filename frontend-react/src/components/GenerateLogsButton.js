import React from 'react';
import { postLog } from '../services/api.js';

function GenerateLogsButton() {
  const handleClick = async () => {
    try {
      const newLog = { message: 'Log generat automat' };
      const result = await postLog(newLog);
      console.log('Log trimis:', result);
    } catch (err) {
      console.error('Eroare:', err.message);
    }
  };

  return <button onClick={handleClick}>Generează Log</button>;
}

export default GenerateLogsButton;

