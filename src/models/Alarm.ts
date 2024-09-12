import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn, Timestamp } from 'typeorm';
import { System } from './System';

@Entity()
export class Alarm{

    @PrimaryGeneratedColumn()
    id!: number

    @ManyToOne(() => System, (system) => system.id)
    @JoinColumn({name: 'id'})
    systemId!: number

    @Column()
    isActive!: boolean

    @Column()
    createdAt!: Timestamp

}