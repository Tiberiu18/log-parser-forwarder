const request = require('supertest');
const { createServer } = require('../index.js'); 

let app;

beforeAll(() => {
  app = createServer(); 
});

describe('GET /', () => {
  it('should return API is running...', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe('API is running...');
  });
});

describe('GET /health', () => {
  it('should return health status', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.message).toBe('NodeJS API is up...');
  });
});

describe('POST /logs', () => {
  it('should save logs successfully', async () => {
    const payload = {
      logs: [['log line 1', 'log line 2'], ['log line 3']]
    };
    const res = await request(app).post('/logs').send(payload);
    expect(res.statusCode).toBe(200);
    expect(res.body.message).toBe('Logs saved successfully.');
  });

  it('should return 400 for invalid payload', async () => {
    const res = await request(app).post('/logs').send({ logs: ['not', 'nested'] });
    expect(res.statusCode).toBe(400);
    expect(res.body.error).toBe('The payload must be a list of lists');
  });
});

describe('GET /metrics', () => {
  it('should return Prometheus metrics', async () => {
    const res = await request(app).get('/metrics');
    expect(res.statusCode).toBe(200);
    expect(res.headers['content-type']).toContain('text/plain');
    expect(res.text).toContain('http_requests_total');
  });
});

