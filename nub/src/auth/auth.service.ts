import { HttpException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import * as otpGenerator from 'otp-generator';
import { EmailSignUpDto } from './dto/email-signup.dto';
import { VerifyEmailOtpDTO } from './dto/verify-email-otp';
import { JwtService } from '@nestjs/jwt';
import { EmailSignInDto } from './dto/email-signin.dto';

@Injectable()
export class AuthService {
  constructor (private readonly prismaService: PrismaService, private readonly jwtService: JwtService) {}
  
  async signupEmail(body: EmailSignUpDto) {

    const emailExists = await this.prismaService.user.findUnique({
      where: {
        email: body.email
      }
    });

    if (emailExists) {
      throw new HttpException('Email already exists', 409);
    }

    const otp = otpGenerator.generate(4, { upperCaseAlphabets: false, specialChars: false });
    // to be removed
    console.log(otp);

    await this.prismaService.user.create({
      data: {
        email: body.email,
        name: body.name,
        otp: otp
      }
    });
  }

  async signinEmail(body: EmailSignInDto) {
    const user = await this.prismaService.user.findUnique({
      where: {
        email: body.email
      },
      select: {
        id: true,
        email: true,
        name: true,
        phoneNumber: true,
        role: true,
        picture: true,
        settings: true,
        createdAt: true,
        updatedAt: true
      }
    });

    if (!user) {
      throw new HttpException('User not found', 404);
    }

    const otp = otpGenerator.generate(4, { upperCaseAlphabets: false, specialChars: false });
    // to be removed
    console.log(otp);

    await this.prismaService.user.update({
      where: {
        email: body.email
      },
      data: {
        otp: otp
      }
    });

    return user;
  }

  async verifyOTPEmail(body: VerifyEmailOtpDTO) {
    const user = await this.prismaService.user.findUnique({
      where: {
        email: body.email
      }
    });

    if (!user) {
      throw new HttpException('User not found', 404);
    }

    if (user.otp !== body.otp) {
      throw new HttpException('Invalid OTP', 401);
    }

 
    const token = await this.jwtService.sign({ email: user.email, sub: user.id, role: user.role });
    return { access_token: token };
  }
}
