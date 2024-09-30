import { SystemsRepository } from "../repositories/SystemsRepository";

export class SystemsService {
    private systemsRepository: SystemsRepository;

    constructor(systemsRepository: SystemsRepository){
        this.systemsRepository = systemsRepository;
    }

    async getSystemDetails (systemId: string) {
        const systemDetails = await this.systemsRepository.getSystemDetails(systemId)
        return systemDetails;
    }
}