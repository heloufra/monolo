import { Controller, Body, Patch, Param } from '@nestjs/common';
import { SettingService } from './setting.service';
import { UpdateSettingDto } from './dto/update-setting.dto';
import { Roles } from 'src/common/role.decorator';
import { GetCurrentUser } from 'src/common/user.decorator';

@Controller('setting')
export class SettingController {
  constructor(private readonly settingService: SettingService) {}

  @Roles(['costumer', 'delivery_person', 'admin'])
  @Patch()
  async update(@GetCurrentUser() user: any, @Body() updateSettingDto: UpdateSettingDto) {
    return await this.settingService.update(user, updateSettingDto);
  }
}
