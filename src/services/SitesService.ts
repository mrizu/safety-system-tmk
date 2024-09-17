import { SitesRepository } from "../repositories/SitesRepository";

export class SitesService {
    private sitesRepository: SitesRepository;

    constructor() {
        this.sitesRepository = new SitesRepository();
    }

    async getSitesInfo() {
        const siteNames = await this.sitesRepository.getAllSiteNames()
        const userCounts = await this.sitesRepository.getAllSitesUserCount()
        const activeAlarmsCount = await this.sitesRepository.getAllSitesActiveAlarms()

        const sitesData = siteNames.map(site => {
            const uc = userCounts.find(u => u.site_id === site.id)?.user_count || 0;
            const ac = activeAlarmsCount.find(a => a.site_id === site.id)?.active_alarms_count || 0;

            return {
                site_id: site.id,
                site_name: site.name,
                user_count: uc,
                active_alarms: ac,
            };
        })

        return sitesData;
    }
}