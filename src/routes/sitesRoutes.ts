import { Request, Response, Router } from 'express';
import { ss } from '../main';

const router = Router();


router.get('/sites', async (req: Request, res: Response) => {
    try {
        const result = await ss.sitesService.getSitesInfo()
        res.json(result);
    } catch (error) {
        console.error(error)
        res.status(500).json({ message: 'Error fetching sites' });
    }
});

router.get('/sites/:siteId', async (req: Request, res: Response) => {
    const { siteId } = req.params;
    try {
        const result = await ss.sitesService.getSiteDetails(siteId)
        res.json(result)
    } catch (error) {
        console.error(error)
        res.status(500).json({ message: 'Error fetching site details' });
    }
})

export default router;
