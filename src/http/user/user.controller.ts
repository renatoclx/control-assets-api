import {
  Controller,
  Post,
  HttpCode,
  Body,
  Get,
  Delete,
  Param,
  Patch,
} from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserTypeDTO } from './dto/create-user-type.dto';
import { CreateUserDTO } from './dto/create-user.dto';
import { FindUserByEmailDTO } from './dto/find-user-by-email.dto';
import { UpdateUserDTO } from './dto/update-user.dto';
@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post('type')
  @HttpCode(201)
  async createUserType(@Body() createUserTypeDTO: CreateUserTypeDTO) {
    return this.userService.createUserType(createUserTypeDTO);
  }

  @Post()
  @HttpCode(201)
  async createUser(@Body() createUserDTO: CreateUserDTO) {
    return this.userService.createUser(createUserDTO);
  }

  @Get()
  @HttpCode(200)
  async findAll() {
    return this.userService.findAll();
  }

  @Get('email')
  @HttpCode(200)
  async findByEmail(@Body() findUserByEmailDTO: FindUserByEmailDTO) {
    return this.userService.findByEmail(findUserByEmailDTO);
  }

  @Patch(':id')
  @HttpCode(200)
  async update(@Param('id') id: string, @Body() updateUserDTO: UpdateUserDTO) {
    return this.userService.update(id, updateUserDTO);
  }

  @Delete(':id')
  @HttpCode(204)
  async delete(@Param('id') id: string) {
    return this.userService.delete(id);
  }
}
