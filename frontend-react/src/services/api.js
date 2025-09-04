// src/api.js
const apiUrl = process.env.REACT_APP_API_URL;

export async function getLogs() {
  const response = await fetch(`${apiUrl}/logs`);
  if (!response.ok) {
    throw new Error('Eroare la preluarea logurilor');
  }
  return await response.json();
}

export async function postLog(logData) {
  const response = await fetch(`${apiUrl}/logs`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(logData),
  });
  if (!response.ok) {
    throw new Error('Eroare la trimiterea logului');
  }
  return await response.json();
}

