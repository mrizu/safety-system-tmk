import { Router } from 'express';
import { Request, Response } from 'express';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { client, SECRET_KEY } from '../config';

const router = Router();

router.post('/login', async (req: Request, res: Response) => {
    const username = req.body.username;
    const password = req.body.password

    if (!username || !password) {
        return res.status(400).json({ message: 'Username and password are required.' });
    }

    try {
        const result = await client.query('SELECT * FROM users WHERE username = $1', [username]);
        const user = result.rows[0];

        if (!user) {
            return res.status(401).json({ message: 'Invalid credentials.' });
        }

        const isMatch = await bcrypt.compare(password, user.password_hash);

        if (!isMatch) {
            return res.status(401).json({ message: 'Invalid credentials.' });
        }

        const token = jwt.sign({ userId: user.id }, SECRET_KEY, { expiresIn: '1h' });

        return res.json({ token });
    } catch (error) {
        console.error(error)
        return res.status(500).json({ message: 'Server error.' });
    }
});

export default router;
