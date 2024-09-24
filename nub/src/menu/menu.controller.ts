import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { MenuService } from './menu.service';
import { CreateMenuDto } from './dto/create-menu.dto';
import { UpdateMenuDto } from './dto/update-menu.dto';
import { ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/common/role.decorator';
import { GetCurrentUser } from 'src/common/user.decorator';
import { Restaurant } from 'src/restaurant/entities/restaurant.entity';

@ApiTags('menu')
@Controller('menu')
export class MenuController {
  constructor(private readonly menuService: MenuService) {}

  @Roles(['admin', 'restaurant'])
  @Post()
  async create(@GetCurrentUser() user: any, @Body() createMenuDto: CreateMenuDto) {
    return await this.menuService.create(createMenuDto);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get("restaurant/:id")
  async findAll(@Param('id') id: string) {
    return await this.menuService.findAll(id);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get('dish/:id')
  async findOne(@Param('id') id: string) {
    return await this.menuService.findOne(id);
  }

  @Roles(['admin', 'restaurant'])
  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateMenuDto: UpdateMenuDto) {
    return await this.menuService.update(id, updateMenuDto);
  }

  @Roles(['admin', 'restaurant'])
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return await this.menuService.remove(id);
  }
}
