import { HttpException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import * as otpGenerator from 'otp-generator';
import { CreateAuthDto } from './dto/create-auth.dto';
import { VerifyEmailOtpDTO } from './dto/verify-email-otp';
import { JwtService } from '@nestjs/jwt';
import { access } from 'fs';

@Injectable()
export class AuthService {
  constructor (private readonly prismaService: PrismaService, private readonly jwtService: JwtService) {}
  
  async registerEmail(body: CreateAuthDto) {

    // check if email already exists
    const emailExists = await this.prismaService.client.findUnique({
      where: {
        email: body.email
      }
    });

    if (emailExists) {
      throw new HttpException('Email already exists', 400);
    }

    const otp = otpGenerator.generate(4, { upperCaseAlphabets: false, specialChars: false });
    console.log(otp);

    return await this.prismaService.client.create({
      data: {
        email: body.email,
        name: body.name,
        otp: otp
      }
    });
  }

  async loginEmail(body: any) {
    // check if user is exists

    const user = await this.prismaService.client.findUnique({
      where: {
        email: body.email
      }
    });

    if (!user) {
      throw new HttpException('User not found', 404);
    }

    // generate otp
    const otp = otpGenerator.generate(4, { upperCaseAlphabets: false, specialChars: false });
    console.log(otp);

    // update otp
    await this.prismaService.client.update({
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
    // check if user is exists
    const user = await this.prismaService.client.findUnique({
      where: {
        email: body.email
      }
    });

    if (!user) {
      throw new HttpException('User not found', 404);
    }

    if (user.otp !== body.otp) {
      throw new HttpException('Invalid OTP', 400);
    }

    // sign a jwt and return it
    const token = this.jwtService.sign({ email: user.email });
    return { access_token: token };
  }
}
