"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const pg_1 = require("pg");
const client = new pg_1.Client({
    user: 'admin',
    host: 'localhost',
    database: 'safety_system_tmk',
    password: 'admin',
    port: 5432,
});
client.connect()
    .then(() => console.log('Database connected successfully'))
    .catch((err) => console.error('Database connection error:', err));
exports.default = client;
