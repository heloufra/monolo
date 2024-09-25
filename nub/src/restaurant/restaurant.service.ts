import { Injectable } from '@nestjs/common';
import { UpdateRestaurantDto } from './dto/update-restaurant.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class RestaurantService {
  constructor (private readonly prismaService: PrismaService) {}

  async findAll() {
    return await this.prismaService.dish.findMany();
  }

  async findOne(user: any) {
    return await this.prismaService.dish.findUnique({
      where: {
        id: user.id,
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
        picture: updateRestaurantDto.pictureURL
      }
    });
  }


  async findbyid(id: string) {
    return await this.prismaService.dish.findUnique({
      where: {
        id: id,
      },
    });
  }
}
