import { Exclude } from 'class-transformer';

export class Address {
  constructor(
    public id: string,
    public name: string,
    public street: string,
    public city: string,
    public state: string,
    public country: string,
    public postalCode: string,
    public latitude: number,
    public longitude: number,
    public userId?: string,
    public restaurantId?: string,
  ) {}

  @Exclude()
  readonly createdAt: Date = new Date();

  @Exclude()
  readonly updatedAt: Date = new Date();
}