import { NestFactory, Reflector } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { SupabaseAuthGuard } from 'src/auth/guards/supa.guard';
import { RolesGuard } from './auth/guards/role.guard';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe());
  app.useGlobalGuards(new SupabaseAuthGuard());
  app.useGlobalGuards(new RolesGuard(new Reflector()));

  const config = new DocumentBuilder()
    .setTitle('Olo server')
    .setDescription('The Olo API description')
    .setVersion('1.0')
    .addTag('Olo')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  await app.listen(3000);
}
bootstrap();
