import { IsString, IsNotEmpty, IsPhoneNumber } from "class-validator";

export class AddressRegisterDto {
    @IsString()
    @IsNotEmpty()
    address: string;

    @IsString()
    @IsNotEmpty()
    name: string;

    @IsString()
    @IsNotEmpty()
    phone: string;
}

export class AddressDto {
    @IsString()
    @IsNotEmpty()
    address: string;

    @IsString()
    @IsNotEmpty()
    name: string;
}