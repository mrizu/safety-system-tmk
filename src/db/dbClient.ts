import { Client } from 'pg';

const client = new Client({
    user: 'admin',
    host: 'localhost',
    database: 'safety_system_tmk',
    password: 'admin',
    port: 5432,
});

client.connect()
    .then(() => console.log('Database connected successfully'))
    .catch((err) => console.error('Database connection error:', err));

export default client;
