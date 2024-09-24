import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { AddressService } from './address.service';
import  { AddressRegisterCoordinatesDto, AddressRegisterDto, CreateAddressCoordinatesDto, CreateAddressDto } from './dto/create-address.dto';
import { UpdateAddressDto } from './dto/update-address.dto';
import { ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/common/role.decorator';
import { GetCurrentUser } from 'src/common/user.decorator';

/**
 * note: I need to add wall to prevent someone scrapping all users addresses.
 */
@ApiTags('address')
@Controller('address')
export class AddressController {
  constructor(private readonly addressService: AddressService) {}

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Post('register')
  async addressRegister(
    @GetCurrentUser() user: any,
    @Body() addressRegisterDto: AddressRegisterDto,
  ) {
    return await this.addressService.addressRegister(user, addressRegisterDto);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Post('register/coordinates')
  async addressRegistercoordinates(
    @GetCurrentUser() user: any,
    @Body() addressRegisterDto: AddressRegisterCoordinatesDto,
  ) {
    return await this.addressService.addressRegisterCoordinates(user, addressRegisterDto);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Post('create')
  async create(
    @GetCurrentUser() user: any,
    @Body() createAddressDto: CreateAddressDto,
  ) {
    return await this.addressService.create(user, createAddressDto);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Post('create/coordinates')
  async createCoordinates(
    @GetCurrentUser() user: any,
    @Body() createAddressDto: CreateAddressCoordinatesDto,
  ) {
    return await this.addressService.createCoordinates(user, createAddressDto);
  }

  @Roles(['admin'])
  @Post('create/:id')
  async createForUser(
    @GetCurrentUser() user: any,
    @Param('id') id: string,
    @Body() createAddressDto: CreateAddressDto,
  ) {
    return await this.addressService.createWithId(user, createAddressDto, id);
  }


  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get('self')
  async getAll(@GetCurrentUser() user: any) {
    return await this.addressService.findAll(user);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get('user/:id')
  async findAllForUser(@GetCurrentUser() user: any, @Param('id') id: string) {
    return await this.addressService.findManyForUser(user, id);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Patch(':id')
  async update(
    @GetCurrentUser() user: any,
    @Param('id') id: string,
    @Body() updateAddressDto: UpdateAddressDto,
  ) {
    return await this.addressService.update(user, id, updateAddressDto);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Delete(':id')
  async remove(@GetCurrentUser() user: any, @Param('id') id: string) {
    return await this.addressService.remove(user, id);
  }
}
