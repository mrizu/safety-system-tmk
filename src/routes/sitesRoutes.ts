import { Request, Response, Router } from 'express';
import { SitesService } from '../services/SitesService';

const router = Router();

const sitesService = new SitesService();

router.get('/sites', async (req: Request, res: Response) => {
    try {
        const result = await sitesService.getSitesInfo()
        res.json(result);
    } catch (error) {
        console.error(error)
        res.status(500).json({ message: 'Error fetching sites' });
    }
});

export default router;
