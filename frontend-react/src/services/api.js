// src/api.js
const apiUrl = process.env.REACT_APP_API_URL;
export async function getLogs() {
  console.log('Fetching from:', `${apiUrl}/logs`);
  try {
    const response = await fetch(`${apiUrl}/logs`);
    const text = await response.text();
    console.log('Raw response:', text);
    return JSON.parse(text);
  } catch (err) {
    console.error('Fetch error:', err);
    throw err;
  }
}

	
	
export async function postLog(logData) {
  console.log(`${apiUrl}`);
  const response = await fetch(`${apiUrl}/logs`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(logData),
  });
  if (!response.ok) {
    throw new Error('Error under src/services/api.js postLog function');
  }
  return await response.json();
}

