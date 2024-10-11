import { Injectable } from '@nestjs/common';
import { UpdateRestaurantDto } from './dto/update-restaurant.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class RestaurantService {
  constructor(private readonly prismaService: PrismaService) {}

  async findAll() {
    return await this.prismaService.restaurant.findMany({
      select: {
        id: true,
        name: true,
        logo: true,
        pictures: true,
        rating: true,
        phoneNumber: true,
        address: true,
        reviews: true,
        dishes: true,
      },
    });
  }

  async findOne(user: any) {
    return await this.prismaService.restaurant.findUnique({
      where: {
        id: user.id,
      },
      select: {
        id: true,
        name: true,
        logo: true,
        pictures: true,
        rating: true,
        phoneNumber: true,
        address: true,
        reviews: true,
        dishes: true,
      },
    });
  }

  async update(user: any, updateRestaurantDto: UpdateRestaurantDto) {
    return await this.prismaService.restaurant.update({
      where: {
        id: user.id,
      },
      data: {
        name: updateRestaurantDto.name,
        logo: updateRestaurantDto.logo,
        pictures: updateRestaurantDto.pictures,
      },
      select: {
        id: true,
        name: true,
        logo: true,
        pictures: true,
        rating: true,
        phoneNumber: true,
        address: true,
        reviews: true,
        dishes: true,
      },
    });
  }

  async findbyid(id: string) {
    return await this.prismaService.restaurant.findUnique({
      where: {
        id: id,
      },
      select: {
        id: true,
        name: true,
        logo: true,
        pictures: true,
        rating: true,
        phoneNumber: true,
        address: true,
        reviews: true,
        dishes: true,
      },
    });
  }
}
