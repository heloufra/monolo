import { IsString, IsNumber, IsBoolean } from 'class-validator';

export class CreateReviewDto {
    @IsBoolean()
    forRestaurant: boolean;
    
    @IsNumber()
    rating: number;

    @IsString()
    comment: string;
}
