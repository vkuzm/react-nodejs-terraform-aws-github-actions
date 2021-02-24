const express = require('express');
const bodyParse = require('body-parser');
const cors = require('cors');
const ip = require('ec2-publicip');
const db = require('./db');

const corsOptions = {
  origin: '*'
};

const app = express();
app.use(cors(corsOptions));
app.use(bodyParse.json());

const getServerIp = async () => {
  const data = await fetch('http://169.254.169.254/latest/meta-data/public-ipv4');
  return await data.json();
};

// Home page
app.get('/', async (req, res) => {
  console.log(req);
  console.log(res);
  
  res.json('Hello World!!!');
});

// Show all users
app.get('/users', async (req, res) => {
    const users = await db.query('SELECT * FROM users');

    res.json({
      users: users.rows,
      server_ip: getServerIp()
    });
});

// Show a single user
app.get('/users/:userId', async (req, res) => {
    const userId = req.params['userId'];
    const users = await db.query('SELECT * FROM users WHERE user_id = $1', [userId]);

    res.json({
      users: users.rows[0],
      server_ip: getServerIp()
    });
});

// Add a new user
app.post('/users', (req, res) => {
  console.log(req);
  console.log(res);
});

// Delete s single user
app.delete('/users/:userId', (req, res) => {
  console.log(req);
  console.log(res);
});

app.listen('8081', () => {
  console.log('Listening on port 8081');
});
