import { IsEmail } from 'class-validator';

export class EmailSignInDto {
    @IsEmail()
    email: string;
}
