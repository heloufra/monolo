import { Body, Controller, Delete, Get, Put, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { GetCurrentUser } from 'src/common/user.decorator';
import { Roles } from 'src/common/role.decorator';
import {
  UserUpdateDataDto,
  UserUpdateEmailDto,
  UserUpdatePhonelDto,
  UserVerifyEmailDto,
  UserVerifyPhoneDto,
} from './dto/user.dto';

/*
 * for updating user email and phone number we take the request body and update the user information using supabasd api
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

  /*
   * for updating name and user picture url
   */
  @Roles(['costumer', 'delivery_person', 'admin'])
  @Put('update')
  async updateUser(
    @GetCurrentUser() user: any,
    @Body() data: UserUpdateDataDto,
  ) {
    // update the user information
  }

  /*
   * for updating email
   */
  @Roles(['costumer', 'delivery_person', 'admin'])
  @Put('update/email')
  async updateUserEmail(
    @GetCurrentUser() user: any,
    @Body() data: UserUpdateEmailDto,
  ) {
    // update the user information
  }

  /*
   * for updating phone number
   */
  @Roles(['costumer', 'delivery_person', 'admin'])
  @Put('update/phone')
  async updateUserPhone(
    @GetCurrentUser() user: any,
    @Body() data: UserUpdatePhonelDto,
  ) {
    // update the user information
  }

  /*
   * for verifying email
   */
  @Roles(['costumer', 'delivery_person', 'admin'])
  @Put('verify/email')
  async verifyEmail(
    @GetCurrentUser() user: any,
    @Body() data: UserVerifyEmailDto,
  ) {
    // update the user information
  }

  /*
   * for verifying phone number
   */
  @Roles(['costumer', 'delivery_person', 'admin'])
  @Put('verify/phone')
  async verifyPhone(
    @GetCurrentUser() user: any,
    @Body() data: UserVerifyPhoneDto,
  ) {
    // update the user information
  }
}
