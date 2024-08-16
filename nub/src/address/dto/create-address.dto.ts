import { IsString, IsNotEmpty, IsNumber, IsOptional } from "class-validator";

export class CreateAddressDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsString()
    @IsNotEmpty()
    street: string;

    @IsString()
    @IsNotEmpty()
    @IsOptional()
    city: string;

    @IsString()
    @IsNotEmpty()
    @IsOptional()
    state: string;

    @IsString()
    @IsNotEmpty()
    @IsOptional()
    country: string;

    @IsString()
    @IsNotEmpty()
    @IsOptional()
    postalCode: string;

    @IsNumber()
    @IsOptional()
    latitude: number;

    @IsNumber()
    @IsOptional()
    longitude: number;
}
