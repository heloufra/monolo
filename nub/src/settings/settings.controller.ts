import { Controller, Get, Body, Patch, Delete } from '@nestjs/common';
import { SettingsService } from './settings.service';
import { UpdateSettingDto } from './dto/update-setting.dto';
import { Roles } from 'src/common/role.decorator';
import { GetCurrentUser } from 'src/common/user.decorator';

@Controller('settings')
export class SettingsController {
  constructor(private readonly settingsService: SettingsService) {}

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get()
  async findOne(@GetCurrentUser() user: any) {
    return await this.settingsService.findOne(user);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Patch()
  async update(@GetCurrentUser() user: any, @Body() updateSettingDto: UpdateSettingDto) {
    return await this.settingsService.update(user, updateSettingDto);
  }

  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Delete()
  async remove(@GetCurrentUser() user: any) {
    return await this.settingsService.remove(user);
  }
}
