import { Body, Controller, Delete, Get, Put, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { GetCurrentUser } from 'src/common/user.decorator';
import { Roles } from 'src/common/role.decorator';
import { UserUpdateDataDto } from './dto/user.dto';
import { ApiTags } from '@nestjs/swagger';

/*
 * for updating user email and phone number we take the request body and update the user information using supabasd api
 */

@ApiTags('user')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Roles(['admin'])
  @Get('all')
  async getAllUsers() {
    return await this.userService.findAll();
  }

  @Roles(['customer', 'delivery_person', 'admin'])
  @Get('me')
  async getUser(@GetCurrentUser() user: any) {
    return await this.userService.findOne(user);
  }

  /*
   * for updating name and user picture url
   */
  @Roles(['customer', 'delivery_person', 'admin'])
  @Put('update')
  async updateUser(
    @GetCurrentUser() user: any,
    @Body() data: UserUpdateDataDto,
  ) {
    return await this.userService.updateUser(user, data);
  }

  /*
   * for updating email
   */
  // @Roles(['costumer', 'delivery_person', 'admin'])
  // @Put('update/email')
  // async updateUserEmail(
  //   @GetCurrentUser() user: any,
  //   @Body() data: UserUpdateEmailDto,
  // ) {
  //   return await this.userService.updateUserEmail(user, data);
  // }

  // /*
  //  * for updating phone number
  //  */
  // @Roles(['costumer', 'delivery_person', 'admin'])
  // @Put('update/phone')
  // async updateUserPhone(
  //   @GetCurrentUser() user: any,
  //   @Body() data: UserUpdatePhonelDto,
  // ) {
  //   return await this.userService.updateUsePhone(user, data);
  // }

  // /*
  //  * for verifying email
  //  */
  // @Roles(['costumer', 'delivery_person', 'admin'])
  // @Put('verify/email')
  // async verifyEmail(
  //   @GetCurrentUser() user: any,
  //   @Body() data: UserVerifyEmailDto,
  // ) {
  //   return await this.userService.verifyUserEmail(user, data);
  // }

  // /*
  //  * for verifying phone number
  //  */
  // @Roles(['costumer', 'delivery_person', 'admin'])
  // @Put('verify/phone')
  // async verifyPhone(
  //   @GetCurrentUser() user: any,
  //   @Body() data: UserVerifyPhoneDto,
  // ) {
  //   return await this.verifyPhone(user, data);
  // }
}
