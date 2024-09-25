import { IsNotEmpty, IsObject, IsString, ValidateNested } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class DishDto {
    @ApiProperty()
    @IsString()
    id: string;
    
    @ApiProperty()
    @IsString()
    quantity: number;

}
export class CreateOrderDto {
  @ApiProperty()
  @IsObject()
  @ValidateNested()
  @Type(() => DishDto)
  dishes: DishDto[];

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  restaurantId: string;
}
