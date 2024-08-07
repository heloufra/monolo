import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserService {
    constructor (private readonly prismaService: PrismaService) {}


    async findOne(user: any) {
         return await this.prismaService.user.findUnique({
            where: {
                id: user.id
            },
            select: {
                id: true,
                name: true,
                email: true,
                phoneNumber: true,
                role: true,
                picture: true,
                settings: true,
                orders: true,
                reviews: true,
                addresses: true,
                createdAt: true,
                updatedAt: true,
            }
        });

    }
}
