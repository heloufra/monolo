import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
// import { ClientModule } from './client/client.module';
import { AuthModule } from './auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './prisma/prisma.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { UserModule } from './user/user.module';

@Module({
  imports: [ AuthModule, ConfigModule.forRoot({
    envFilePath: ['.env'],
    isGlobal: true,
  }), PrismaModule, ServeStaticModule.forRoot({
    rootPath: join(__dirname, '..', 'public'),
  }), UserModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
