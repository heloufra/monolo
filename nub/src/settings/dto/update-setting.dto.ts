import { IsString, IsNotEmpty, IsBoolean } from 'class-validator';

export class UpdateSettingDto {
    @IsString()
    @IsNotEmpty()
    notificationPreference: string;

    @IsBoolean()
    darkMode: boolean;

    @IsBoolean()
    enableDataCollection: boolean;
}
