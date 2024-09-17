import { client } from "../config";

export class SitesRepository {

    async getAllSiteNames() {
        const result = await client.query('SELECT id, name FROM sites');
        return result.rows;
    }

    async getAllSitesUserCount () {
        const result = await client.query(`
            SELECT site_id, COUNT(user_id) as user_count
            FROM users_sites
            GROUP BY site_id;
        `);

        return result.rows;
    }

    async getAllSitesActiveAlarms () {
        const result = await client.query(`
            SELECT s.id as site_id, COUNT (a.id) as active_alarms_count
            FROM sites s
            LEFT JOIN systems sys ON s.id = sys.site_id
            LEFT JOIN alarms a ON sys.id = a.system_id AND a.is_active = true
            GROUP BY s.id
            `);

        return result.rows
    }
}