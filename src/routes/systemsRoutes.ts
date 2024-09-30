import { Request, Response, Router } from "express";
import { ss } from "../main";

const router = Router();

router.get('/systems/:systemId', async (req: Request, res: Response) => {
    const { systemId } = req.params
    try {
        const result = await ss.systemsService.getSystemDetails(systemId)
        res.json(result);
    } catch (error) {
        console.error(error)
        res.status(500).json({ message: 'Error fetching alarms' });
    }
})

export default router;