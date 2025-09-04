import React from 'react';
import LogViewer from './components/LogViewer';
import GenerateLogsButton from './components/GenerateLogsButton';
import GrafanaLink from './components/GrafanaLink';

function App() {
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

