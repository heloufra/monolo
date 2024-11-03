import { Injectable } from '@nestjs/common';
import { GetCurrentUser } from 'src/common/user.decorator';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserUpdateDataDto, UserUpdateEmailDto, UserUpdatePhonelDto, UserVerifyEmailDto, UserVerifyPhoneDto } from './dto/user.dto';
import { emit } from 'process';

@Injectable()
export class UserService {
    constructor (private readonly prismaService: PrismaService) {}
    

    async findOne(id: string) {
         return await this.prismaService.user.findUnique({
            where: {
                id: id
            },
            // select: {
            //     id: true,
            //     email: true,
            //     phone: true,
            //     roles: true,
            //     createdAt: true,
            //     updatedAt: true,
            // },
            include: {

                profile: true,
                Settings: true,
                addresses: true,
            }
        });

    }

    // async findAll() {
    //     return await this.prismaService.user.findMany({
    //         select: {
    //             id: true,
    //             name: true,
    //             email: true,
    //             phoneNumber: true,
    //             role: true,
    //             picture: true,
    //             settings: true,
    //             orders: true,
    //             reviews: true,
    //             addresses: true,
    //             createdAt: true,
    //             updatedAt: true,
    //         }
    //     });
    // }

    // async updateUser(user : any, data: UserUpdateDataDto) {
    //     return await this.prismaService.user.update({
    //         where: {
    //             id: user.id,
    //         },
    //         data: {
    //             name: data.name,
    //             picture: data.pictureURL,
    //             phoneNumber: data.phoneNumber,
    //             email: data.email,
    //         },
    //         select: {
    //             id: true,
    //             name: true,
    //             email: true,
    //             phoneNumber: true,
    //             role: true,
    //             picture: true,
    //             settings: true,
    //             orders: true,
    //             reviews: true,
    //             addresses: true,
    //             createdAt: true,
    //             updatedAt: true,
    //         }
    //     });
    // }

    // async updateUserEmail(user: any, email: UserUpdateEmailDto) {
    //     // send request to supabase auth to change email
    
    // }

    // async verifyUserEmail(user: any, verifyDto: UserVerifyEmailDto) {
    //     // send request to supabase auth to verifyDto email
    //     // change user email
    // }


    // async updateUsePhone(user: any, email: UserUpdatePhonelDto) {
    //     // send request to supabase auth to change phone number
    
    // }

    // async verifyUserPhone(user: any, verifyDto: UserVerifyPhoneDto) {
    //     // send request to supabase auth to verifyDto phone number
    //     // change user phone number
    // }
}
