import { SitesRepository } from "../repositories/SitesRepository";
import { SystemsRepository } from "../repositories/SystemsRepository";

export class SitesService {
    private sitesRepository: SitesRepository;
    private systemsRepository: SystemsRepository;

    constructor(sitesRepository: SitesRepository, systemsRepository: SystemsRepository) {
        this.sitesRepository = sitesRepository;
        this.systemsRepository = systemsRepository;
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

    async getSiteDetails(siteId: string) {
        const siteDetails = await this.systemsRepository.getDetailsBySiteId(siteId)
        return siteDetails
    }
}