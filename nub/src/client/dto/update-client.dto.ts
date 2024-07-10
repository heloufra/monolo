import { IsString, IsNotEmpty } from "class-validator";

export class UpdateClientDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsString()
    @IsNotEmpty()
    email: string;

    @IsString()
    @IsNotEmpty()
    phone: string;
}