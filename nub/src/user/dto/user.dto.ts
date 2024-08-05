import { IsString, IsNotEmpty, IsOptional, IsNumber } from 'class-validator';

export class UserUpdateDataDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsString()
    @IsNotEmpty()
    picture: string;
}


export class UserUpdateEmailDto {
    @IsString()
    @IsNotEmpty()
    email: string;
}

export class UserUpdatePhonelDto {
    @IsString()
    @IsNotEmpty()
    phone: string;
}

export class UserVerifyEmailDto {
    @IsString()
    @IsNotEmpty()
    email: string;

    @IsString()
    @IsNotEmpty()
    code: string;
}

export class UserVerifyPhoneDto {
    @IsString()
    @IsNotEmpty()
    phone: string;

    @IsString()
    @IsNotEmpty()
    code: string;
}