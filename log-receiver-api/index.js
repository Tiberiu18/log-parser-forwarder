const express = require("express");
const asyncHandler = require("express-async-handler");
const path = require("path");
const fs = require("fs");
const app = express();

app.use(express.json());


app.get("/", (req,res) => {
    res.send("API is running...");
});

app.post("/logs", asyncHandler(async(req,res)=> {
    const {logs} = req.body
    console.log(logs);

    // It has to be a list of lists
    if (!Array.isArray(logs) || !logs.every(sub => Array.isArray(sub))){
        return res.status(400).json({error: 'The payload must be a list of lists'});
    }

    const flatLogs = logs.flat();

    const timestamped = flatLogs.map(line => `[${new Date().toISOString()}] ${line}`);


    const content = timestamped.join('\n') + '\n';

    const logDir = path.join(__dirname, '../logs');
    if (!fs.existsSync(logDir)) {
        fs.mkdirSync(logDir);
    }

    fs.appendFile(path.join(logDir, 'app.log'), content, err => {
        if (err) {
        console.error('Error writing: ', err);
        return res.status(500).json({ error: 'Could not write to file.'});
        }

        res.status(200).json({message: 'Logs saved successfully.'});
    })

}))




const PORT = process.env.port || 3000

app.listen(PORT, console.log(`server running port ${PORT}...`))

