import { Injectable } from '@nestjs/common';
import { CreateReviewDto } from './dto/create-review.dto';
import { UpdateReviewDto } from './dto/update-review.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ReviewsService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(user: any, createReviewDto: CreateReviewDto) {
    /**
     * change restaurant rating or dish rating
     */
    return await 'This action adds a new review';
  }

  async findOne(id: string) {
    return await `This action returns a #${id} review`;
  }

  async update(user: any, id: string, updateReviewDto: UpdateReviewDto) {
    /**
     * change restaurant rating or dish rating
     */
    return await `This action updates a #${id} review`;
  }

  async remove(user: any, id: string) {
    /**
     * change restaurant rating or dish rating
     */
    return await `This action removes a #${id} review`;
  }
}
