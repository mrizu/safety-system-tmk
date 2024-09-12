import { Entity, PrimaryGeneratedColumn, Column, OneToMany, JoinColumn, ManyToOne } from 'typeorm';
import { Alarm } from './Alarm';
import { Site } from './Site';

@Entity()
export class System{
   @PrimaryGeneratedColumn()
   @OneToMany(() => Alarm, (alarm) => alarm.systemId)
   id!: number 

   @Column()
   name!: string

   @ManyToOne(() => Site, (site) => site.id)
   @JoinColumn({name: 'id'})
   siteId!: number
}