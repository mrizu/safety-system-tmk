import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { System } from './System';
import { UserSite } from './UserSite';

@Entity()
export class Site{
    @OneToMany(() => System, (system) => system.siteId)
    @OneToMany(() => UserSite, (userSite) => userSite.siteId)
    @PrimaryGeneratedColumn()
    id!: number

    @Column()
    name!: string
}