import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import { EmailSignUpDto } from './dto/email-signup.dto';
import { EmailSignInDto } from './dto/email-signin.dto';
import { VerifyEmailOtpDTO } from './dto/verify-email-otp';


@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('signup/email')
  create(@Body() body: EmailSignUpDto) {
    this.authService.signupEmail(body);

  }

  @Post('signin/email')
  login(@Body() body: EmailSignInDto) {
    try {
      return this.authService.signinEmail(body);
    } catch (error) {
      return error;
    }
  }

  @Post('verifyOTP')
  verifyOTP(@Body() body: VerifyEmailOtpDTO) {
    return this.authService.verifyOTPEmail(body);
  }
}
