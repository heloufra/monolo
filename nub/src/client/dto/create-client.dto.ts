import { IsEmail, IsString, IsOptional, IsBoolean } from 'class-validator';

export class CreateClientDto {
  @IsString()
  readonly name: string;

  @IsString()
  readonly surname: string;

  @IsEmail()
  readonly email: string;

  @IsString()
  readonly password: string;

  @IsString()
  readonly phone: string;
}
