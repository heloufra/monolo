import { Injectable } from '@nestjs/common';
import { CreateMenuDto } from './dto/create-menu.dto';
import { UpdateMenuDto } from './dto/update-menu.dto';
import { PrismaService } from 'nestjs-prisma';


/**
 * 
model Dish {
  id           String      @id @default(uuid())
  name         String
  description  String
  price        Float
  rating       Float
  pictures     String[]
  restaurantId String
  restaurant   Restaurant  @relation(fields: [restaurantId], references: [id])
  orderItems   OrderItem[]
  createdAt    DateTime    @default(now())
  updatedAt    DateTime    @updatedAt
  reviews      Review[]
  @@map("dishes")
}
 */
@Injectable()
export class MenuService {
  constructor(private readonly prismaService: PrismaService) {}
  
  async create(createMenuDto: CreateMenuDto) {
    return await this.prismaService.dish.create({
      data: {
        name: createMenuDto.name,
        description: createMenuDto.description,
        price: createMenuDto.price,
        rating: createMenuDto.rating,
        pictures: createMenuDto.pictures,
        restaurant: {
          connect: {
            id: createMenuDto.restaurantId,
          },
        },

      },
      select: {
        id: true,
        name: true,
        description: true,
        price: true,
        rating: true,
        pictures: true,
        restaurant: true,
      },
    });
  }

  async findAll(id: string) {
    return await this.prismaService.dish.findMany({
      where: {
        restaurantId: id,
      },
      select: {
        id: true,
        name: true,
        description: true,
        price: true,
        rating: true,
        pictures: true,
        restaurant: true,
      },
    });
  }

  async findOne(id: string) {
    return await this.prismaService.dish.findUnique({
      where: {
        id: id,
      },
      select: {
        id: true,
        name: true,
        description: true,
        price: true,
        rating: true,
        pictures: true,
        restaurant: true,
      },
    });
  }

  async update(id: string, updateMenuDto: UpdateMenuDto) {
    return await this.prismaService.dish.update({
      where: {
        id: id,
      },
      data: {
        name: updateMenuDto.name,
        description: updateMenuDto.description,
        price: updateMenuDto.price,
        rating: updateMenuDto.rating,
        pictures: updateMenuDto.pictures,
        restaurant: {
          connect: {
            id: updateMenuDto.restaurantId,
          },
        },
      },
      select: {
        id: true,
        name: true,
        description: true,
        price: true,
        rating: true,
        pictures: true,
        restaurant: true,
      },
    });
  }

  async remove(id: string) {
    await this.prismaService.dish.delete({
      where: {
        id: id,
      },
    });
  }
}
