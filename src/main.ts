import { SitesRepository } from "./repositories/SitesRepository";
import { SystemsRepository } from "./repositories/SystemsRepository";
import { SitesService } from "./services/SitesService";
import { SystemsService } from "./services/SystemsService";

class SafetySystem {
    constructor() {}

    get sitesService(){
        return new SitesService(
            new SitesRepository(),
            new SystemsRepository()
        )
    }

    get systemsService(){
        return new SystemsService(
            new SystemsRepository()
        )
    }
}

export const ss = new SafetySystem();