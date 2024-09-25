import { IsNotEmpty, IsObject, IsString, ValidateNested } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class OrderItem {
    @ApiProperty()
    @IsString()
    id: string;
    
    @ApiProperty()
    @IsString()
    quantity: number;

    @ApiProperty()
    @IsString()
    orderId: number;
}

export class UpdateOrderDto {
  @ApiProperty()
  @IsObject()
  @ValidateNested()
  @Type(() => OrderItem)
  orderItems: OrderItem[];

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  restaurantId: string;
}
