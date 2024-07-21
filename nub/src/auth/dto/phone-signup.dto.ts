import { IsString, IsNotEmpty } from 'class-validator';

export class PhoneSignUpDto {
    @IsString()
    @IsNotEmpty()
    phone: string;

    @IsString()
    @IsNotEmpty()
    name: string;
} 
