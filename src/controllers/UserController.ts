import { Request, Response } from 'express';
import client from '../db/dbClient';

export class UserController {
    async getUsers(req: Request, res: Response) {
        try {
            const result = await client.query('SELECT * FROM users');
            res.json(result.rows);
        } catch (error) {
            res.status(500).json({ error: 'Failed to fetch users' });
        }
    }

    async getUserById(req: Request, res: Response) {
        const { id } = req.params;
        try {
            const result = await client.query('SELECT * FROM users WHERE id = $1', [id]);
            if (result.rows.length === 0) {
                return res.status(404).json({ error: 'User not found' });
            }
            res.json(result.rows[0]);
        } catch (error) {
            res.status(500).json({ error: 'Failed to fetch user' });
        }
    }

}
