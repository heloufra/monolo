import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { ReviewsService } from './reviews.service';
import { CreateReviewDto } from './dto/create-review.dto';
import { UpdateReviewDto } from './dto/update-review.dto';
import { Roles } from 'src/common/role.decorator';
import { GetCurrentUser } from 'src/common/user.decorator';

@Controller('reviews')
export class ReviewsController {
  constructor(private readonly reviewsService: ReviewsService) {}

  @Roles(['costumer', 'admin'])
  @Post()
  async create(
    @GetCurrentUser() user: any,
    @Body() createReviewDto: CreateReviewDto,
  ) {
    return await this.reviewsService.create(user, createReviewDto);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.reviewsService.findOne(id);
  }

  @Patch(':id')
  update(
    @GetCurrentUser() user: any,
    @Param('id') id: string,
    @Body() updateReviewDto: UpdateReviewDto,
  ) {
    return this.reviewsService.update(user, id, updateReviewDto);
  }

  @Roles(['costumer', 'admin'])
  @Delete(':id')
  remove(@GetCurrentUser() user: any, @Param('id') id: string) {
    return this.reviewsService.remove(user, id);
  }
}
