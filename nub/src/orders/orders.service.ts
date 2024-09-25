import { HttpException, Injectable } from '@nestjs/common';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { PrismaService } from 'nestjs-prisma';
import { OrderStatus } from '@prisma/client';

@Injectable()
export class OrdersService {
  constructor(private readonly prismaService: PrismaService) {}
  async create(user: any, createOrderDto: CreateOrderDto) {
    const { dishes, restaurantId } = createOrderDto;
    const dishes_ = await this.prismaService.dish.findMany({
      where: {
        id: {
          in: dishes.map((dish) => dish.id),
        },
      },
    });

    if (!dishes_ || dishes_.length !== dishes_.length) {
      throw new HttpException('Dish not found', 404);
    }

    const restaurant = await this.prismaService.restaurant.findUnique({
      where: {
        id: restaurantId,
      },
    });

    if (!restaurant) {
      throw new HttpException('Restaurant not found', 404);
    }

    const total = dishes_.reduce((acc, dish) => {
      const dishQuantity = dishes.find((d) => d.id === dish.id).quantity;
      return acc + dish.price * dishQuantity;
    }, 0);

    const order = await this.prismaService.order.create({
      data: {
        total: total,
        customerId: user.id,
        status: OrderStatus.PENDING,
        restaurantId: createOrderDto.restaurantId,
        orderItems: {
          create: createOrderDto.dishes.map((dish) => ({
            dishId: dish.id,
            quantity: dish.quantity,
          })),
        },
      },
      include: {
        orderItems: true,
      },
    });
    return order;
  }

  async findAll(user: any) {
    if (user.role === 'ADMIN') {
      return await this.prismaService.order.findMany({
        include: {
          orderItems: true,
        },
      });
    }
    return await this.prismaService.order.findMany({
      where: {
        restaurantId: user.id,
      },
      include: {
        orderItems: true,
      },
    });
  }

  async findAllForUser(user: any) {
    const orders = await this.prismaService.order.findMany({
      where: {
        customerId: user.id,
      },
      include: {
        orderItems: true,
      },
    });
    return orders;
  }

  async findOne(id: string) {
    const order = await this.prismaService.order.findUnique({
      where: {
        id: id,
      },
      include: {
        orderItems: true,
      },
    });
    return order;
  }

  async update(id: string, updateOrderDto: UpdateOrderDto) {
    const updated = await this.prismaService.order.update({
      where: {
        id: id,
      },
      data: {
        orderItems: {
          update: updateOrderDto.orderItems.map((dish) => ({
            where: {
              id: dish.id,
            },
            data: {
              quantity: dish.quantity,
            },
          })),
        },
      },
      include: {
        orderItems: true,
      },
    });

    return updated;
  }

  async remove(user: any, id: string) {
    const usero = await this.prismaService.user.findUnique({
      where: {
        id: user.id,
      },
    });

    if (!usero) {
      throw new HttpException('User not found', 404);
    }

    const order = await this.prismaService.order.findUnique({
      where: {
        id: id,
      },
    });

    if (!order) {
      throw new HttpException('Order not found', 404);
    }

    if (order.customerId !== user.id) {
      throw new HttpException('Unauthorized', 401);
    }

    return await this.prismaService.order.delete({
      where: {
        id: id,
      },
    });
  }
}
