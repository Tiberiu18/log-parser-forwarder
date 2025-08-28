const express = require('express');
const asyncHandler = require('express-async-handler');
const path = require('path');
const fs = require('fs');
const app = express();
// Official Prometheus library for Node-js
const client = require('prom-client');
app.use(express.json());


const collectDefault = client.collectDefaultMetrics;
collectDefault(); // CPU, MEM etc. metrics, 
// prometheus will see these metrics as process_cpu_user_seconds_total etc.

// Defining a custom Container to count each request and keeps labels
const httpReqs = new client.Counter(
	{
	name: 'http_requests_total', 
	help: 'Total API calls',
	labelNames: ['route', 'method', 'code'],
	}
);

app.get('/', (req,res) => {
    // Inc => increment, this basically increments the custom counter
    httpReqs.inc({route: '/', method: 'GET', code:200});
    res.send('API is running...');
});


app.post('/logs', asyncHandler(async(req,res)=> {
    httpReqs.inc({ route: '/logs', method: 'POST', code:200});
    const {logs} = req.body;
    console.log(logs);

    // It has to be a list of lists
    if (!Array.isArray(logs) || !logs.every(sub => Array.isArray(sub))){
        return res.status(400).json({error: 'The payload must be a list of lists'});
    }

    const originalFileName = req.headers['X-Log-File-Name'] || 'unknown.log';
    const originalTimestamp = req.headers['X-Log-Timestamp'] || new Date().toISOString();

    console.log(originalFileName);
    console.log(originalTimestamp);

    const flatLogs = logs.flat();

    const timestamped = flatLogs.map(line => `[${originalTimestamp}] ${line}`);


    const content = `---- Logs from ${originalFileName} @ ${originalTimestamp} ----\n` + timestamped.join('\n') + '\n\n';

    const logDir = path.join(__dirname, '../parsed_logs');
    if (!fs.existsSync(logDir)) {
        fs.mkdirSync(logDir);
    }

    const safeTimestamp = originalTimestamp.replace(/[:]/g, '-');
    const outputFileName = `${originalFileName}_${safeTimestamp}.log`;

    const outputFile = path.join(logDir, outputFileName);

    fs.appendFile(outputFile, content, err => {
        if (err) {
        console.error('Error writing: ', err);
        return res.status(500).json({ error: 'Could not write to file.'});
        }

        res.status(200).json({message: `Logs saved successfully. Original File Name is ${originalFileName} with timestamp ${originalTimestamp}`});
    });

}));

app.get('/metrics', async(req,res) => {
	// Sets the right Content-Type (Prometheus text exposition format)
	// Otherwise, Prometheus will have errors parsing this endpoint
	res.set('Content-Type',client.register.contentType);
	// gathers all metrics registered 
	// default metrics, http_requests_total custom counter
	const metrics = await client.register.metrics(); // this will return a string
	res.end(metrics);

});


app.get('/health', async(req,res) => {
	res.status(200).json({message: 'NodeJS API is up...'});
});


const PORT = process.env.PORT || 3000;

function createServer() {
	return app;
}

if (process.env.NODE_ENV !== 'test') {
app.listen(PORT, '0.0.0.0', () => {
	console.log(`server running on port ${PORT}...`);
});}

module.exports = { createServer };
