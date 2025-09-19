import React from 'react';
import { postLog } from '../services/api';
import { generateLogContent, downloadLogFile } from '../utils/LogGenerator';
import { isValidLogPayload } from '../utils/validation';

function GenerateLogsButton() {
  const handleClick = async () => {
  const logContent = generateLogContent();

  if (!isValidLogPayload(logContent)) {
    console.error('Invalid Payload');
    alert('Error: Invalid log format, nothing has been sent.');
    return;
  }

  // Generate filename with random suffix
  const randomSuffix = Math.random().toString(36).substring(2,10);
  const filename = `generated-log-${randomSuffix}.log`;

  const logText = logContent
    .map(([timestamp, level, message]) => `[${timestamp}] ${level}: ${message}`)
    .join("\n");

  const blob = new Blob([logText], { type: "text/plain" });
  const formData = new FormData();
  formData.append("file", blob, filename);

  try {
    const result = await postLog(formData, true); // true = e formData
    console.log('Log sent successfully:', result);
    downloadLogFile(logContent, filename);
  } catch (err) {
    console.error('Error sending logs:', err.message);
    alert('Log sending has failed.');
  }
};

	
	return <button onClick={handleClick}>Generate and send log</button>;
}

export default GenerateLogsButton;

