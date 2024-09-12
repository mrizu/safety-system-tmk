import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { UserSite } from './UserSite';

@Entity()
export class User {
    @OneToMany(() => UserSite, (userSite) => userSite.userId)
    @PrimaryGeneratedColumn()
    id!: number;

    @Column()
    username!: string;

    @Column()
    passwordHash!: string;
}
