import { Injectable } from '@nestjs/common';
import { UpdateSettingDto } from './dto/update-setting.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class SettingService {
  constructor (private readonly prismaService: PrismaService) {}

  async update(user: any, updateSettingDto: UpdateSettingDto) {
    const res = await this.prismaService.user.update({
      where: {
        id: user.id
      },
      data: {
        settings: {
          update: {
           data: {
            notificationPreference: updateSettingDto.notificationPreference,
            darkMode: updateSettingDto.darkMode,              
            enableDataCollection : updateSettingDto.enableDataCollection
           }
          },
        }
      },
      select: {
        settings: true
      }
    })

    return res;
  }
}
