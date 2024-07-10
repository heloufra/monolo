import { IsBoolean } from "class-validator";

export class DataCollectionDto {
    @IsBoolean()
    enable: boolean;
}