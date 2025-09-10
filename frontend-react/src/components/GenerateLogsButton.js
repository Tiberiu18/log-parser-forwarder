import React from 'react';
import { postLog } from '../services/api';
import { generateLogContent, downloadLogFile } from '../utils/LogGenerator';
import { isValidLogPayload } from '../utils/validation';

function GenerateLogsButton() {
  const handleClick = async () => {
    const logContent = generateLogContent();

    if (!isValidLogPayload(logContent)) {
      console.error('Invalid Payload, validation fails isValidLogPayload function. Must be an array of arrays');
      alert('Error: Invalid log format, nothing has been sent.');
      return;
    }

    try {
      const result = await postLog({ logs: logContent });
      console.log('Log has been successfully sent GenerateLogsButton function:', result);
      downloadLogFile(logContent);
    } catch (err) {
      console.error('Error sending logs:', err.message);
      alert('Log sending has failed.');
    }
  };

  return <button onClick={handleClick}>Generate and send log</button>;
}

export default GenerateLogsButton;

