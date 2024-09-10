import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsOptional, IsNumber } from 'class-validator';

export class UserUpdateDataDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    name: string;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    pictureURL: string;
}


export class UserUpdateEmailDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    email: string;
}

export class UserUpdatePhonelDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    phone: string;
}

export class UserVerifyEmailDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    email: string;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    code: string;
}

export class UserVerifyPhoneDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    phone: string;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    code: string;
}