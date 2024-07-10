import { Controller, Get, Post, Body, Param, UseGuards, Put } from '@nestjs/common';
import { ClientService } from './client.service';
import { UpdateClientDto } from './dto/update-client.dto';
import { AuthGuard } from 'src/auth/auth.guard';
import { AddressDto, AddressRegisterDto } from './dto/address-register.dto';
import { GetCurrentUser } from 'src/common/client.decorator';
import { JwtPayload } from 'src/auth/entities/jwt.entity';
import { DataCollectionDto } from './dto/data-collection.dto';
import { NotificationDto } from './dto/notif.dto';

@Controller('client')
export class ClientController {
  constructor(private readonly clientService: ClientService) {}

  @UseGuards(AuthGuard)
  @Get('profile')
  getProfile(@GetCurrentUser() user: JwtPayload) {
    return this.clientService.getProfile(user);
  }
  
  @UseGuards(AuthGuard)
  @Post('addresss/newaddressRegister')
  create(@Body() addressRegisterDto: AddressRegisterDto, @GetCurrentUser() user: JwtPayload) {
    return this.clientService.newAddressRegister(user, addressRegisterDto);
  }

  @UseGuards(AuthGuard)
  @Post('addresss/newaddress')
  newAddress(@Body() address: AddressDto, @GetCurrentUser() user: JwtPayload) {
    return this.clientService.newAddress(user, address);
  }

  @UseGuards(AuthGuard)
  @Put('addresss/updateAddress/:id')
  updateAddress(@Param('id') id: string, @Body() addressRegisterDto: AddressRegisterDto, @GetCurrentUser() user: JwtPayload) {
    return this.clientService.updateAddress(id, user, addressRegisterDto);
  }

  @UseGuards(AuthGuard)
  @Get('addresss/getAddress')
  getAddress(@GetCurrentUser() user: JwtPayload) {
    return this.clientService.getAddress(user);
  }

  @UseGuards(AuthGuard)
  @Post('addresss/deleteAddress/:id')
  deleteAddress(@Param('id') id: string, @GetCurrentUser() user: JwtPayload) {
    return this.clientService.deleteAddress(id, user);
  }

  @UseGuards(AuthGuard)
  @Post('cd')
  deleteAcount(@GetCurrentUser() user: JwtPayload) {
    return this.clientService.deleteClient(user);
  }

  @UseGuards(AuthGuard)
  @Post('privacy/datacollection')
  dataCollection(@GetCurrentUser() user: JwtPayload, @Body() dataCollectionDto: DataCollectionDto){
    return this.clientService.dataCollection(user, dataCollectionDto);
  }

  @UseGuards(AuthGuard)
  @Post('notification/update')
  updateNotification(@GetCurrentUser() user: JwtPayload,@Body() notificationDto: NotificationDto){
    return this.clientService.updateNotification(user, notificationDto);
  }


  @UseGuards(AuthGuard)
  @Put('update')
  update(@GetCurrentUser() user: JwtPayload, @Body() updateClientDto: UpdateClientDto) {
    return this.clientService.update(user, updateClientDto);
  }
}
