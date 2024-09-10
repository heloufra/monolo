import {
  HttpCode,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { CreateReviewDto } from './dto/create-review.dto';
import { UpdateReviewDto } from './dto/update-review.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ReviewsService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(user: any, createReviewDto: CreateReviewDto) {
    if (createReviewDto.forRestaurant)
      return await this.createReviewForRestaurant(user, createReviewDto);
    else return await this.createReviewForDish(user, createReviewDto);
  }
  
  async findRestaurantReview(id: string) {
    const resto = await this.prismaService.restaurant.findUnique({
      where: {
        id: id,
      },
      select: {
        reviews: true,
      }
    });

    if (!resto) throw new HttpException('Not found', HttpStatus.NOT_FOUND);

    return resto.reviews;
  }

  async findDishRview(id: string) {
    const dish = await this.prismaService.dish.findUnique({
      where: {
        id: id,
      },
      select: {
        reviews: true,
      }
    });

    if (!dish) throw new HttpException('Not found', HttpStatus.NOT_FOUND);

    return dish.reviews;
  }

  async update(user: any, id: string, updateReviewDto: UpdateReviewDto) {
    /**
     * change restaurant rating or dish rating
     */
    return await this.prismaService.$transaction(async (prisma) => {
      const review = await this.prismaService.review.findUnique({
        where: {
          id: id,
        },
      });

      if (!review) throw new HttpException("Not found", HttpStatus.NOT_FOUND);
      if (user.id !== review.userId) throw new HttpException("Forbidden", HttpStatus.FORBIDDEN);

      const reviewUpdated = await this.prismaService.review.update({
        where: {
          id: review.id,
        },
        data: {
          rating: updateReviewDto.rating,
          comment: updateReviewDto.comment,
        }
      });

      if (review.dishId) await this.updateDishRating(review.dishId);
      await this.updateRestaurantRating(review.dishId);
      return reviewUpdated;
    });
  }

  async remove(user: any, id: string) {
    /**
     * change restaurant rating or dish rating
     */
    return await this.prismaService.$transaction(async (prisma) => {
      const review = await this.prismaService.review.findUnique({
        where: {
          id: id,
        },
        select:{
          userId: true,
          dishId: true
        },
      });
      if (!review) throw new HttpException('Not found', HttpStatus.NOT_FOUND);
      if (user.id !== review.userId) throw new HttpException('Forbidden', HttpStatus.FORBIDDEN);

      await this.prismaService.review.delete({where:{id: id}});
      if (review.dishId) await this.updateDishRating(review.dishId);
      await this.updateRestaurantRating(review.dishId);
    });
  }

  async createReviewForDish(user: any, createReviewDto: CreateReviewDto) {
    return await this.prismaService.$transaction(async (prisma) => {
      const dish = await prisma.dish.findUnique({
        where: {
          id: createReviewDto.reviewedId,
        },
      });

      if (!dish) throw new HttpException('Not found', HttpStatus.NOT_FOUND);

      const review = await prisma.review.create({
        data: {
          rating: createReviewDto.rating,
          comment: createReviewDto.comment,
          restaurant: {
            connect: {
              id: dish.restaurantId,
            },
          },
          dish: {
            connect: {
              id: dish.id,
            },
          },
          user: {
            connect: {
              id: user.id,
            },
          },
        },
      });

      await this.updateDishRating(createReviewDto.reviewedId);

      return review;
    });
  }

  async createReviewForRestaurant(user: any, createReviewDto: CreateReviewDto) {
    return this.prismaService.$transaction(async (prisma) => {
      const restaurant = await prisma.restaurant.findUnique({
        where: {
          id: createReviewDto.reviewedId,
        },
      });

      if (!restaurant)
        throw new HttpException('Not found', HttpStatus.NOT_FOUND);

      const review = await prisma.review.create({
        data: {
          rating: createReviewDto.rating,
          comment: createReviewDto.comment,
          restaurant: {
            connect: {
              id: restaurant.id,
            },
          },
          user: {
            connect: {
              id: user.id,
            },
          },
        },
      });

      await this.updateRestaurantRating(createReviewDto.reviewedId);

      return review;
    });
  }

  async updateRestaurantRating(restaurantId: string) {
    const updatedRestaurant = await this.prismaService.restaurant.update({
      where: {
        id: restaurantId,
      },
      data: {
        rating: {
          set: await this.prismaService.review
            .aggregate({
              where: {
                restaurantId: restaurantId,
              },
              _avg: {
                rating: true,
              },
            })
            .then((result) => result._avg.rating || 0),
        },
      },
    });

    return updatedRestaurant;
  }

  async updateDishRating(dishId: string) {
    const updatedDish = await this.prismaService.dish.update({
      where: {
        id: dishId,
      },
      data: {
        rating: {
          set: await this.prismaService.review
            .aggregate({
              where: {
                dishId: dishId,
              },
              _avg: {
                rating: true,
              },
            })
            .then((result) => result._avg.rating || 0),
        },
      },
    });

    return updatedDish;
  }
}
