import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsBoolean, IsEnum, IsIn } from 'class-validator';
const NotificationPreference = ['EMAIL', 'SMS', 'NONE'];

export class UpdateSettingDto {
    @ApiProperty()
    @IsIn(NotificationPreference)
    notificationPreference: 'EMAIL' | 'SMS' | 'NONE';

    @ApiProperty()
    @IsBoolean()
    darkMode: boolean;

    @ApiProperty()
    @IsBoolean()
    enableDataCollection: boolean;
}
