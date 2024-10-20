import { Controller, Body, Patch, Param, Get } from '@nestjs/common';
import { SettingService } from './setting.service';
import { UpdateNotificationSettingDto, UpdatePrivacySettingDto, UpdateSettingDto } from './dto/update-setting.dto';
import { Roles } from 'src/common/role.decorator';
import { GetCurrentUser } from 'src/common/user.decorator';

@Controller('settings')
export class SettingController {
  constructor(private readonly settingService: SettingService) {}

  @Roles(['customer',])
  @Get()
  async getSettings(@GetCurrentUser() user: any) {
    return await this.settingService.getSettings(user);
  }

  @Roles(['customer',])
  @Patch('privacy')
  async updatePrivacySettings(@GetCurrentUser() user: any, @Body() updateSettingDto: UpdatePrivacySettingDto) {
    return await this.settingService.updatePrivacySettings(user, updateSettingDto);
  }

  @Roles(['customer',])
  @Patch('notifications')
  async updateNotificationSettings(@GetCurrentUser() user: any, @Body() updateSettingDto: UpdateNotificationSettingDto) {
    console.log(updateSettingDto);
    return await this.settingService.updateNotificationSettings(user, updateSettingDto);
  }

  @Roles(['customer',])
  @Patch('delete')
  async deleteUser(@GetCurrentUser() user: any) {
    return await this.settingService.delete(user);
  }
}
