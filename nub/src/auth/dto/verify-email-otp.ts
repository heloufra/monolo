import { IsString, IsNotEmpty, IsEmail } from 'class-validator';

export class VerifyEmailOtpDTO {
    @IsEmail()
    email: string;

    @IsString()
    @IsNotEmpty()
    otp: string;
}