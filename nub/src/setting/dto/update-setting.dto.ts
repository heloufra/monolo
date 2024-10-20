import { IsString, IsBoolean , IsNotEmpty, IsIn } from 'class-validator';

const np = ["EMAIL" , "SMS" ,"NONE"];
export class UpdateSettingDto {
    @IsBoolean()
    darkMode: boolean;

    @IsBoolean()
    enableDataCollection: boolean;

    @IsIn(np)
    notificationPreference: "EMAIL" | "SMS" | "NONE";
}


export class UpdatePrivacySettingDto {
  @IsBoolean()
  locationEnabled: boolean;

  @IsBoolean()
  dataSharingEnabled: boolean;
}

export class UpdateNotificationSettingDto {
  @IsBoolean()
  orderUpdates: boolean;

  @IsBoolean()
  promotions: boolean;

  @IsBoolean()
  emailNotifications: boolean;
}

