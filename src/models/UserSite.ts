import { Entity, ManyToOne, JoinColumn } from 'typeorm';
import { User } from './User';
import { Site } from './Site';

@Entity()
export class UserSite{
    @ManyToOne(() => User, (user) => user.id)
    @JoinColumn({name: "id"})
    userId!: number

    @ManyToOne(() => Site, (site) => site.id)
    @JoinColumn({ name: "id" })
    siteId!: number
}