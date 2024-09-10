import { Injectable } from '@nestjs/common';
import { UpdateRestaurantDto } from './dto/update-restaurant.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class RestaurantService {
  constructor (private readonly prismaService: PrismaService) {}

  async findAll() {
    const restaurants = await this.prismaService.dish.findMany();
    return restaurants;
  }

  async findOne(user: any) {
    const restaurant = await this.prismaService.dish.findUnique({
      where: {
        id: user.id,
      },
    });
    return restaurant;
  }

  async update(user: any, updateRestaurantDto: UpdateRestaurantDto) {
    const restaurant = await this.prismaService.restaurant.update({
      where: {
        id: user.id,
      },
      data: {
        name: updateRestaurantDto.name,
        picture: updateRestaurantDto.pictureURL
      }
    });

    return restaurant;
  }


  async findbyid(id: string) {
    const restaurant = await this.prismaService.dish.findUnique({
      where: {
        id: id,
      },
    });
    return restaurant;
  }
}
