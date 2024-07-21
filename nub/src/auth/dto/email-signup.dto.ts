import { IsEmail, IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class EmailSignUpDto {
    @IsEmail()
    email: string;

    @IsString()
    @IsNotEmpty()
    name: string;

    @IsOptional()
    role: "CUSTOMER" | "VENDOR" | "COURIER";
}
