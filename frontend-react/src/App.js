import React from 'react';
import LogViewer from './components/LogViewer';
import GenerateLogsButton from './components/GenerateLogsButton';
import GrafanaLink from './components/GrafanaLink';
import UploadLog from './components/UploadLog';

function App() {
  console.log('App is rendering');
  console.log(process.env.REACT_APP_PARSER_URL);
  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial' }}>
      <h1>Log Dashboard</h1>
      <GenerateLogsButton />
      <GrafanaLink />
      <LogViewer />
      <UploadLog />
    </div>
  );
}

export default App;

