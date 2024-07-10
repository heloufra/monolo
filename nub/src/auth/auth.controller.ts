import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { VerifyEmailOtpDTO } from './dto/verify-email-otp';


@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register/email')
  create(@Body() body: CreateAuthDto) {
    /* email with name */
    this.authService.registerEmail(body);

  }

  @Post('login')
  login(@Body() body: any) {
    /* phone number or email */
    try {
      return this.authService.loginEmail(body);
    } catch (error) {
      return error;
    }
  }

  @Post('verifyOTP')
  verifyOTP(@Body() body: VerifyEmailOtpDTO) {
    /* phone number or email with OTP */
    return this.authService.verifyOTPEmail(body);
  }

  @Post('google/login')
  googleLogin(@Body() body: any) {
    /* google login */

    // send token body.token to google to get user details
    const obj = {
      email: body.email,
      name: body.name,
    };
    return this.authService.loginEmail(body);

  }

  @Post('google/Singup')
  googleSignup(@Body() body: any) {
    /* google login */

    // send token body.token to google to get user details
    const obj = {
      email: body.email,
      name: body.name,
    };

    this.authService.registerEmail(body);
  }
}
