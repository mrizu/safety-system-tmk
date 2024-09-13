import { Router } from 'express';
import { loginUser } from '../controllers/UserController';
import client from '../db/dbClient';

const router = Router();

router.get('/users', async (req, res) => {
    try {
        const result = await client.query('SELECT * FROM users');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch users' });
    }
});

router.post('/login', loginUser);

export default router;
