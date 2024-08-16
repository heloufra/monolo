import { Injectable } from '@nestjs/common';
import { GetCurrentUser } from 'src/common/user.decorator';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserService {
    constructor (private readonly prismaService: PrismaService) {}
    

    async getMe(@GetCurrentUser() user: any) {

        const res = await this.prismaService.user.findUnique({
            where: {
                id: user.id
            }
        });

        return res;
    }
}
