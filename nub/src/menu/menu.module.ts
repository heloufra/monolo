import { Module } from '@nestjs/common';
import { MenuService } from './menu.service';
import { MenuController } from './menu.controller';
import { PrismaModule } from 'nestjs-prisma';

@Module({
  controllers: [MenuController],
  providers: [MenuService],
  imports: [PrismaModule],
})
export class MenuModule {}
