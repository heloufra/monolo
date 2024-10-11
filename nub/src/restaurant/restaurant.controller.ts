import { Controller, Get, Post, Body, Patch, Param, Delete, Put } from '@nestjs/common';
import { RestaurantService } from './restaurant.service';
import { UpdateRestaurantDto } from './dto/update-restaurant.dto';
import { ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/common/role.decorator';
import { GetCurrentUser } from 'src/common/user.decorator';

@ApiTags('restaurant')
@Controller('restaurant')
export class RestaurantController {
  constructor(private readonly restaurantService: RestaurantService) {}

  @Roles(['customer', 'delivery_person', 'admin', 'restaurant'])
  @Get('all')
  async getAllUsers() {
    return await this.restaurantService.findAll();
  }

  @Roles(['customer', 'delivery_person', 'admin', 'restaurant'])
  @Get('me')
  async getUser(@GetCurrentUser() user: any) {
    return await this.restaurantService.findOne(user);
  }

  @Roles(['customer', 'delivery_person', 'admin', 'restaurant'])
  @Get(':id')
  async getRestoId(@GetCurrentUser() user: any, @Param() id: string) {
    return await this.restaurantService.findbyid(id);
  }

  @Roles(['admin', 'restaurant'])
  @Put('update')
  async updateResto(
    @GetCurrentUser() user: any,
    @Body() data: UpdateRestaurantDto,
  ) {
    return await this.restaurantService.update(user, data);
  }
}
