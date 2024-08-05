import { Controller, Delete, Get, Put, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { GetCurrentUser } from 'src/common/user.decorator';
import { Roles } from 'src/common/role.decorator';

/*
 *  the UserController class is a basic controller class that will be used to handle requests to the /user endpoint
 *  CUSTOMER and DELIVERY_PERSON users able get their own user information, update their user information, and delete their user information
 */

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Roles(['admin'])
  @Get('all')
  async getAllUsers() {
    // get all users
  }

  @Roles(['costumer', 'delivery_person', 'admin'])
  @Get('me')
  async getUser(@GetCurrentUser() user: any) {
    // get the user information
  }

  @Roles(['costumer', 'delivery_person', 'admin'])
  @Put('update')
  async updateUser(@GetCurrentUser() user: any) {
    // update the user information
  }

  @Roles(['costumer', 'delivery_person', 'admin'])
  @Delete('me')
  async deleteUser(@GetCurrentUser() user: any) {
    // delete the user information
  }
}
