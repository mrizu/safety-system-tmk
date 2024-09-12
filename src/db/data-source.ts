import { DataSource } from 'typeorm';
import { User } from '../models/User';
import { Site } from '../models/Site';
import { System } from '../models/System';
import { Alarm } from '../models/Alarm';
import { UserSite } from '../models/UserSite';

export const AppDataSource = new DataSource({
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'admin',
    password: 'admin',
    database: 'safety_system_tmk',
    entities: [User, Site, System, Alarm, UserSite],
    synchronize: true,
});
