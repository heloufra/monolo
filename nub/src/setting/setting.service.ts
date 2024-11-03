// import { Injectable } from '@nestjs/common';
// import { UpdateNotificationSettingDto, UpdatePrivacySettingDto, UpdateSettingDto } from './dto/update-setting.dto';
// import { PrismaService } from 'src/prisma/prisma.service';

// @Injectable()
// export class SettingService {
//   constructor (private readonly prismaService: PrismaService) {}


//   async updatePrivacySettings(user: any, updateSettingDto: UpdatePrivacySettingDto) {
//     // Update privacy settings in the database for the user
//     await this.prismaService.settings.update({
//       where: {
//         userId: user.id
//       },
//       data: {
//         locationEnabled: updateSettingDto.locationEnabled,
//         dataSharingEnabled: updateSettingDto.dataSharingEnabled
//       }
//     });
//   }

//   async updateNotificationSettings(user: any, updateSettingDto: UpdateNotificationSettingDto) {
//     await this.prismaService.settings.update({
//       where: {
//         userId: user.id
//       },
//       data: {
//         orderUpdates: updateSettingDto.orderUpdates,
//         promotions: updateSettingDto.promotions,
//         emailNotifications: updateSettingDto.emailNotifications
//       }
//     });
//   }

//   async getSettings(user: any) {
//     const setting = await this.prismaService.settings.findUnique({
//       where: {
//         userId: user.id
//       },
//       select: {
//         id: true,
//         userId: true,
//         darkMode: true,
//         locationEnabled: true,
//         dataSharingEnabled: true,
//         orderUpdates: true,
//         promotions: true,
//         deliveryStatus: true,
//         emailNotifications: true,
//         createdAt: true,
//         updatedAt: true
//       }
//     });
//     return setting;
//   }

//   async delete(user: any) {
//     await this.prismaService.user.update({
//       where: {
//         id: user.id
//       },
//       data: {
//         deleted: false,
//         deletedAt: new Date(),
//       // }
//     });
//   }
// }
