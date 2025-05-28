import express from 'express';


const app = express();

app.use(express.json());


app.get("/", (req,res) => {
    res.send("API is running...");
});






const PORT = process.env.port || 5000

app.listen(PORT, console.log(`server running port ${PORT}...`))

