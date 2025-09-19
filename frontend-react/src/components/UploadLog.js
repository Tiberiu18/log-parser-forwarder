import React, { useState } from 'react';
import { postLog } from '../services/api'; 

function UploadLogButton() {
  const [selectedFile, setSelectedFile] = useState(null);

  const handleFileChange = (e) => {
    setSelectedFile(e.target.files[0]); //save the file in state
  };

  const handleUpload = async () => {
    if (!selectedFile) {
      alert('Please select a file first.');
      return;
    }

    const formData = new FormData();
    formData.append('file', selectedFile, selectedFile.name); // keep original name

    try {
      const result = await postLog(formData, true); // true means formData
      console.log('Log uploaded successfully:', result);
      alert('Log uploaded successfully!');
    } catch (err) {
      console.error('Error uploading log:', err.message);
      alert('Log upload failed.');
    }
  };

  return (
    <div>
      <input type="file" accept=".log,.txt" onChange={handleFileChange} />
      <button onClick={handleUpload}>Upload log to parser</button>
    </div>
  );
}

export default UploadLogButton;

