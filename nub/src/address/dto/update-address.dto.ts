import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateAddressDto  {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    name?: string;
  
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    street?: string;
  
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    city?: string;
  
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    state?: string;
  
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    country?: string;
  
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    postalCode?: string;
  
    @ApiProperty()
    @IsNumber()
    @IsOptional()
    latitude?: number;
  
    @ApiProperty()
    @IsNumber()
    @IsOptional()
    longitude?: number;
}
