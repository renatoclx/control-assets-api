import { PrismaService } from '@/prisma/prisma.service';
import { BadRequestException, Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}
  async login(email: string, password: string) {
    const userExists = await this.prisma.user.findUnique({
      where: {
        email: email,
      },
    });

    if (!userExists) {
      throw new BadRequestException('User not found!');
    }

    const passwordMatch = await bcrypt.compare(password, userExists.password);

    if (!passwordMatch) {
      throw new BadRequestException('Password is invalid!');
    }

    const payload = {
      sub: userExists.id,
      email: userExists.email,
      userType: userExists.userTypeId,
    };

    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
