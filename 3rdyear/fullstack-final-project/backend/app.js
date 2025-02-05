const express = require('express');
const cors = require('cors');

const adsRouter = require('./routes/ads');
const usersRouter = require('./routes/users');

const app = express();

app.use(express.json());
app.use(express.static('public'));

app.use(cors({
  origin: [
    'http://localhost:5173',
    'http://localhost:8088',
    'http://127.0.0.1:5173',
    'http://172.16.4.178:80',
    'http://172.16.4.178'
  ]
}));

app.get('/health', (req, res) => {
  res.send("OK 👌");
})

app.use('/api/ads', adsRouter);
app.use('/api/users', usersRouter);

module.exports = app;
