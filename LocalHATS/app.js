const express = require('express');
const app = express();
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// CORS 설정 (Cross-Origin Resource Sharing)
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

// GET 요청 처리
app.get('/', (req, res) => {
    res.send('Hello from Node.js server!');
});

// POST 요청 처리
app.post('/message', (req, res) => {
    const message = req.body.message;
    console.log(`Received message: ${message}`);
    res.send(`Received message: ${message}`);
});

const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});