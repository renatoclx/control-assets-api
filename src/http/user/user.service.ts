import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from '@/prisma/prisma.service';
import { CreateUserTypeDTO } from './dto/create-user-type.dto';
import { CreateUserDTO } from './dto/create-user.dto';
import * as bcrypt from 'bcrypt';
import { FindUserByEmailDTO } from './dto/find-user-by-email.dto';
import { UpdateUserDTO } from './dto/update-user.dto';

@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaService) {}

  async createUserType(createUserTypeDTO: CreateUserTypeDTO) {
    if (!createUserTypeDTO.name) {
      throw new Error('Name is required.');
    }

    await this.prisma.userType.create({
      data: {
        name: createUserTypeDTO.name.toUpperCase(),
      },
    });

    return {
      message: 'User Type created successfully.',
      name: createUserTypeDTO.name,
    };
  }

  async createUser(createUserDTO: CreateUserDTO) {
    const hashedPassword = await bcrypt.hash(createUserDTO.password, 10);

    const userExists = await this.prisma.user.findUnique({
      where: {
        email: createUserDTO.email,
      },
    });

    if (userExists) {
      throw new BadRequestException('User already exists!');
    }

    if (createUserDTO.password !== createUserDTO.confirmPassword) {
      throw new BadRequestException('Password not confirmed!');
    }

    await this.prisma.user.create({
      data: {
        name: createUserDTO.name,
        email: createUserDTO.email,
        password: hashedPassword,
        document: createUserDTO.document ?? null,
        address: createUserDTO.address ?? null,
        status: createUserDTO.status,
        userTypeId: createUserDTO.userTypeId,
        cityId: createUserDTO.cityId,
        departmentId: createUserDTO.departmentId ?? null,
      },
    });

    return {
      message: 'User created successfully.',
      name: createUserDTO.name,
      email: createUserDTO.email,
    };
  }

  async findAll() {
    const users = await this.prisma.user.findMany({
      where: {
        deletedAt: null,
      },
    });

    return {
      message: 'Users found successfully.',
      users,
    };
  }

  async findByEmail(findUserByEmailDTO: FindUserByEmailDTO) {
    const user = await this.prisma.user.findUnique({
      where: {
        email: findUserByEmailDTO.email,
      },
    });

    if (!user) {
      throw new BadRequestException('User not found!');
    }

    return {
      message: 'User found successfully.',
      user: {
        name: user.name,
        email: user.email,
        document: user.document,
        address: user.address,
        status: user.status,
        userTypeId: user.userTypeId,
        cityId: user.cityId,
        departmentId: user.departmentId,
      },
    };
  }

  async update(id: string, updateUserDTO: UpdateUserDTO) {
    await this.prisma.user.update({
      where: {
        id,
      },
      data: updateUserDTO,
    });

    return {
      message: 'User updated successfully.',
    };
  }

  async delete(id: string) {
    await this.prisma.user.update({
      where: {
        id,
      },
      data: {
        deletedAt: new Date(),
      },
    });

    return {
      message: 'User deleted successfully.',
    };
  }
}
