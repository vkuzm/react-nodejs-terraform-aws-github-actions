const express = require('express');
const bodyParse = require('body-parser');
const cors = require('cors');
const db = require('./db');

const corsOptions = {
  origin: '*'
};

const app = express();
app.use(cors(corsOptions));
app.use(bodyParse.json());

// Home page
app.get('/', async (req, res) => {
  console.log(req);
  console.log(res);
  
  res.json('Hello World!');
});


// Show all users
app.get('/users', async (req, res) => {
    const users = await db.query('SELECT * FROM users');
    res.json(users.rows);
});

// Show a single user
app.get('/users/:userId', async (req, res) => {
    const userId = req.params['userId'];
    const users = await db.query('SELECT * FROM users WHERE user_id = $1', [userId]);
    res.json(users.rows[0]);
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
