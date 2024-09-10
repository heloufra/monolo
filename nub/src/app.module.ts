import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './prisma/prisma.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { UserModule } from './user/user.module';
import { APP_GUARD } from '@nestjs/core';
import { SupabaseAuthGuard } from './auth/guards/supa.guard';
import { RolesGuard } from './auth/guards/role.guard';
import { SettingsModule } from './settings/settings.module';
import { AddressModule } from './address/address.module';
import { RestaurantModule } from './restaurant/restaurant.module';
import { MenuModule } from './menu/menu.module';
import { OrdersModule } from './orders/orders.module';
import { ReviewsModule } from './reviews/reviews.module';




@Module({
  imports: [ AuthModule, ConfigModule.forRoot({
    envFilePath: ['.env'],
    isGlobal: true,
  }), PrismaModule, ServeStaticModule.forRoot({
    rootPath: join(__dirname, '..', 'public'),
  }),  UserModule, SettingsModule, AddressModule, RestaurantModule, MenuModule, OrdersModule, ReviewsModule
  ],
  controllers: [AppController],
  providers: [    {
    provide: APP_GUARD,
    useClass: SupabaseAuthGuard,
  },
  {
    provide: APP_GUARD,
    useClass: RolesGuard,
  },
  AppService,
  ],
})
export class AppModule {}
