const express = require('express');
const app = express();
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// CORS 설정 (Cross-Origin Resource Sharing)
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

// GET 요청 처리
app.get('/time', (req, res) => {

    console.log(`[🖥Server] Send message: ${Date().toString()}`);
    res.send(`[🖥Server] Send message: ${Date().toString()}`);
});

// POST 요청 처리
app.post('/message', (req, res) => {
    const message = req.body.message;
    console.log(`[🖥Server] Received message: ${message}`);
    res.send(`[🖥Server] Received message: ${message}`);
});

const port = 4000;
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});