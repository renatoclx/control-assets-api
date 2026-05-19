import { UserStatus } from '@prisma/client';
import {
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsString,
  IsUUID,
  MinLength,
} from 'class-validator';

export class CreateUserDTO {
  @IsString()
  @IsNotEmpty()
  name!: string;

  @IsEmail()
  @IsNotEmpty()
  email!: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  password!: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  confirmPassword?: string;

  @IsString()
  @IsOptional()
  document?: string;

  @IsString()
  @IsOptional()
  address?: string;

  @IsEnum(UserStatus)
  @IsNotEmpty()
  status!: UserStatus;

  @IsUUID()
  @IsNotEmpty()
  userTypeId!: string;

  @IsUUID()
  @IsNotEmpty()
  cityId!: string;

  @IsUUID()
  @IsOptional()
  departmentId?: string;
}
