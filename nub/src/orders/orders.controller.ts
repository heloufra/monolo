import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { ApiTags } from '@nestjs/swagger';
import { GetCurrentUser } from 'src/common/user.decorator';
import { Roles } from 'src/common/role.decorator';

@ApiTags('orders')
@Controller('orders')
export class OrdersController {
  constructor(
    private readonly ordersService: OrdersService,

  ) {}

  @Roles(['CUSTOMER'])
  @Post()
  async create(
    @GetCurrentUser() user: any,
    @Body() createOrderDto: CreateOrderDto,
  ) {
    return await this.ordersService.create(user, createOrderDto);
  }

  @Roles(['ADMIN', 'RESTAURANT'])
  @Get()
  async findAll(@GetCurrentUser() user: any) {
    return await this.ordersService.findAll(user);
  }

  @Roles(['CUSTOMER'])
  @Get('user/all')
  async findAllForUser(@GetCurrentUser() user: any) {
    return await this.ordersService.findAllForUser(user);
  }

  @Roles(['CUSTOMER', 'ADMIN', 'RESTAURANT', 'DELIVERY_PERSON'])
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return await this.ordersService.findOne(id);
  }

  @Roles(['ADMIN', 'RESTAURANT'])
  @Patch('restaurant/status')
  async changeStatus(@GetCurrentUser() user: any) {
    return await this.ordersService.findAll(user);
  }

  @Roles(['RESTAURANT'])
  @Patch(':id/order/status')
  async update(
    @GetCurrentUser() user: any,
    @Param('id') id: string,
    @Body() updateOrderDto: UpdateOrderDto,
  ) {
    return await this.ordersService.update(id, updateOrderDto);
  }

  @Roles(['CUSTOMER'])
  @Delete(':id')
  async remove( @GetCurrentUser() user: any,@Param('id') id: string) {
    return await this.ordersService.remove(user, id);
  }
}
