import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ClientModule } from './client/client.module';
import { VendorModule } from './vendor/vendor.module';
import { ProductModule } from './product/product.module';
import { OrderModule } from './order/order.module';
import { CourierModule } from './courier/courier.module';
import { AuthModule } from './auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './prisma/prisma.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';

@Module({
  imports: [ClientModule, VendorModule, ProductModule, OrderModule, CourierModule, AuthModule, ConfigModule.forRoot({
    envFilePath: ['.env.development.local'],
    isGlobal: true,
  }), PrismaModule, ServeStaticModule.forRoot({
    rootPath: join(__dirname, '..', 'public'),
  })
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
