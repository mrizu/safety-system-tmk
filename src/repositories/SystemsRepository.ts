import { client } from "../config";

export class SystemsRepository {
    async getDetailsBySiteId(siteId: string) {
        const result = await client.query(`
            SELECT
                id,
                name,
                (
                    SELECT 
                        COUNT(a.id)
                    FROM
                        alarms a
                    WHERE
                        a.system_id = s.id AND
                        a.is_active = true
                ) as system_active_alarms_count,
                (
                    SELECT 
                        a.created_at
                    FROM 
                        alarms a
                    WHERE
                        a.system_id = s.id AND
                        a.is_active = true
                    ORDER BY a.created_at DESC
                    LIMIT 1
                ) as last_active_alarm
            FROM
                systems s
            WHERE 
                s.site_id = $1
            `, [siteId])
            return result.rows;
    }

    async getSystemDetails (systemId: string) {
        const result = await client.query(`
            SELECT
                id,
                created_at,
                is_active
            FROM
                alarms a
            WHERE
                system_id = $1
            `, [systemId])

        return result.rows;
    }
}