
import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsOptional, IsNumber } from 'class-validator';

export class AddressRegisterDto {
    @ApiProperty()
    address: AddressDto;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    phone: string;
}

export class AddressDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    name: string;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    street: string;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    city: string;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    state: string;

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    country: string;

    @ApiProperty()
    @IsNumber()
    postalCode: string;

    @ApiProperty()
    @IsNumber()
    @IsOptional()
    latitude: number;

    @ApiProperty()
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