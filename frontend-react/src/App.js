import React from 'react';
import LogViewer from './components/LogViewer';
import GenerateLogsButton from './components/GenerateLogsButton';
import GrafanaLink from './components/GrafanaLink';

function App() {
  console.log('App is rendering');
	console.log('API URL:', process.env.REACT_APP_API_URL);

  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial' }}>
      <h1>Log Dashboard</h1>
      <GenerateLogsButton />
      <GrafanaLink />
      <LogViewer />
    </div>
  );
}

export default App;

