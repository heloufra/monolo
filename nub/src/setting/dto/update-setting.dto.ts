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
