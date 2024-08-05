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


@Module({
  imports: [ AuthModule, ConfigModule.forRoot({
    envFilePath: ['.env'],
    isGlobal: true,
  }), PrismaModule, ServeStaticModule.forRoot({
    rootPath: join(__dirname, '..', 'public'),
  }), UserModule
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
  AppService],
})
export class AppModule {}
