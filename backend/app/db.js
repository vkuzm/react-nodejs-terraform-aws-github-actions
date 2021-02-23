// PostgreSQL client setup
const { Pool } = require('pg');

const pgClient = new Pool({
    user: process.env.PG_USER,
    host: process.env.PG_HOST,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT
});

pgClient.on('error', () => console.log('Lost PG connection'));

pgClient
    .query(`CREATE TABLE IF NOT EXISTS users (
        user_id serial PRIMARY KEY,
        firstname VARCHAR (50),
        lastname VARCHAR (50),
        age VARCHAR (10)
    );`)
    .catch(err => console.log(err));

const initialUsers = [
    {
        firstname: 'john',
        lastname: 'doe',
        age: 18
    },
    {
        firstname: 'nick',
        lastname: 'black',
        age: 25
    },
    {
        firstname: 'matt',
        lastname: 'boo',
        age: 23
    },
    {
        firstname: 'rick',
        lastname: 'mort',
        age: 88
    },
    {
        firstname: 'alex',
        lastname: 'woo',
        age: 55
    },
];

const populateDatabase = async () => {
    const totalUsers = await pgClient.query('SELECT * FROM users');

    if (totalUsers.rows.length === 0) {
        for (let user of initialUsers) {
            const query = `INSERT INTO users (firstname, lastname, age) VALUES ('${user.firstname}', '${user.lastname}', '${user.age}')`;

            pgClient.query(query, (err) => {
                if (err) {
                    console.error(err);
                    return;
                }
                console.log('Data insert successful', query);
            });
        }
    }
};

populateDatabase();

module.exports = {
    query: (text, params, callback) => {
        return pgClient.query(text, params, callback);
    },
};