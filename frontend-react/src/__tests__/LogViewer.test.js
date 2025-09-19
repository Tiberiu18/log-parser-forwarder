import React from 'react';
import { render, screen } from '@testing-library/react';
import LogViewer from '../components/LogViewer';
import { getLogs } from '../services/api';

jest.mock('../services/api');

describe('LogViewer component', () => {
  afterEach(() => {
    jest.clearAllMocks();
  });

  test('Display last 3 logs', async () => {
    getLogs.mockResolvedValue({
      logs: [
        { file: 'log1.txt', timestamp: '2025-09-10T10:00:00Z', content: 'Log 1 content' },
        { file: 'log2.txt', timestamp: '2025-09-10T09:00:00Z', content: 'Log 2 content' },
        { file: 'log3.txt', timestamp: '2025-09-10T08:00:00Z', content: 'Log 3 content' },
      ],
    });

    render(<LogViewer />);

    expect(await screen.findByText(/log1.txt/i)).toBeInTheDocument();
    expect(await screen.findByText(/Log 1 content/i)).toBeInTheDocument();
    expect(await screen.findByText(/log2.txt/i)).toBeInTheDocument();
    expect(await screen.findByText(/log3.txt/i)).toBeInTheDocument();
  });

  test('Display error message if fetch fails', async () => {
    getLogs.mockRejectedValue(new Error('Network error'));

    render(<LogViewer />);

    expect(await screen.findByText(/error/i)).toBeInTheDocument();
    expect(await screen.findByText(/Network error/i)).toBeInTheDocument();
  });
});

