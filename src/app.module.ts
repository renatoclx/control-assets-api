import { Module } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import { PrismaModule } from './prisma/prisma.module';
import { UsersModule } from './http/user/user.module';
import { UserController } from './http/user/user.controller';
import { UserService } from './http/user/user.service';

@Module({
  imports: [PrismaModule, UsersModule],
  controllers: [UserController],
  providers: [PrismaService, UserService],
})
export class AppModule {}
