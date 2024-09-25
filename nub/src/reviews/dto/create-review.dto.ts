import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNumber, IsBoolean } from 'class-validator';

export class CreateReviewDto {
    @ApiProperty()
    @IsString()
    reviewedId: string

    @ApiProperty()
    @IsBoolean()
    forRestaurant: boolean;
    
    @ApiProperty()
    @IsNumber()
    rating: number;

    @ApiProperty()
    @IsString()
    comment: string;
}
