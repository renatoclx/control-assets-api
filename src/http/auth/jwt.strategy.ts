import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    super({
      jwtfromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET as string,
      ignoreExpiration: false,
    });

    console.log('JWT STRATEGY INSTANCIADA');
  }

  async validate(payload: any) {
    return {
      userId: payload.sub,
      email: payload.email,
      userType: payload.userType,
    };
  }
}
