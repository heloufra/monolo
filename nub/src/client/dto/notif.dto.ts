import { IsBoolean, IsString } from "class-validator";

export class NotificationDto {
    @IsBoolean()
    enable: boolean;

    @IsString()
    preference: 'email' | 'sms';
}