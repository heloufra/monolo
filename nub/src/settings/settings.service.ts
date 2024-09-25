import { Injectable } from '@nestjs/common';
import { UpdateSettingDto } from './dto/update-setting.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class SettingsService {
  constructor(private readonly prismaService: PrismaService) {}

  async findOne(user: any) {
    return await this.prismaService.settings.findUnique({
      where: {
        userId: user.id,
      },
    });
  }

  async update(user: any, updateSettingDto: UpdateSettingDto) {
    return await this.prismaService.settings.update({
      where: {
        userId: user.id,
      },
      data: {
        notificationPreference: updateSettingDto.notificationPreference,
        darkMode: updateSettingDto.darkMode,
        enableDataCollection: updateSettingDto.enableDataCollection,
      }
    });
  }

  async remove(user: any) {
    // remove from supabase auth
     await console.log(`This action removes a #${user} setting`);
  }
}
