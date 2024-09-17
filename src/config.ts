import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import { Client } from 'pg';

dotenv.config();

export const client = new Client({
    user: 'admin',
    host: 'localhost',
    database: 'safety_system_tmk',
    password: 'admin',
    port: 5432,
});

client.connect()
    .then(() => console.log('Database connected successfully'))
    .catch((err) => console.error('Database connection error:', err));

export const SECRET_KEY = process.env.SECRET_KEY || 'default_secret_key';

export const generateToken = (userId: number) => {
    return jwt.sign({ userId }, SECRET_KEY, { expiresIn: '1h' });
};

export const verifyToken = (token: string) => {
    try {
        return jwt.verify(token, SECRET_KEY);
    } catch (error) {
        return null;
    }
};

