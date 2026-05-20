import { Module } from '@nestjs/common';
import { PrismaModule } from './prisma/prisma.module';
import { UsersModule } from './http/user/user.module';
import { AuthModule } from './http/auth/auth.module';
import { JwtStrategy } from './http/auth/jwt.strategy';

@Module({
  imports: [PrismaModule, UsersModule, AuthModule],

  providers: [JwtStrategy],
})
export class AppModule {}
