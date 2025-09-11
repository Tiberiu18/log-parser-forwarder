// src/api.js
const parserUrl = process.env.REACT_APP_PARSER_URL;
const backendUrl = process.env.REACT_APP_BACKEND_URL;
export async function getLogs() {
  console.log('Fetching from:', `${backendUrl}/logs`);
  try {
    const response = await fetch(`${backendUrl}/logs`);
    const text = await response.text();
    console.log('Raw response:', text);
    return JSON.parse(text);
  } catch (err) {
    console.error('Fetch error:', err);
    throw err;
  }
}

	
export async function postLog(data, isFormData = false) {
  const options = {
    method: 'POST',
    body: data
  };
  if (!isFormData) {
    options.headers = { 'Content-Type': 'application/json' };
    options.body = JSON.stringify(data);
  }
  const response = await fetch(`${parserUrl}/upload-log`, options);
  if (!response.ok) {
    throw new Error('Error in postLog');
  }
  return await response.json();
}

