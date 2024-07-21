
import { IsString, IsNotEmpty, IsOptional, IsNumber } from 'class-validator';

export class AddressRegisterDto {
    address: AddressDto;

    @IsString()
    @IsNotEmpty()
    phone: string;
}

export class AddressDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsString()
    @IsNotEmpty()
    street: string;

    @IsString()
    @IsNotEmpty()
    city: string;

    @IsString()
    @IsNotEmpty()
    state: string;

    @IsString()
    @IsNotEmpty()
    country: string;

    @IsNumber()
    postalCode: string;

    @IsNumber()
    @IsOptional()
    latitude: number;

    @IsNumber()
    @IsOptional()
    longitude: number;
}

/*
  street       String
  city         String
  state        String
  country      String
  postalCode   String
  latitude     Float
  longitude    Float
 */