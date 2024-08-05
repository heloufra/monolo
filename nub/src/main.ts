import { NestFactory, Reflector } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { SupabaseAuthGuard } from 'src/auth/guards/supa.guard';
import { RolesGuard } from './auth/guards/role.guard';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe());
  app.useGlobalGuards(new SupabaseAuthGuard());
  app.useGlobalGuards(new RolesGuard( new Reflector()));
  await app.listen(3000);
}
bootstrap();
