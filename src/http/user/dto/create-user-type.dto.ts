import { IsNotEmpty, IsString } from 'class-validator';

export class CreateUserTypeDTO {
  @IsString()
  @IsNotEmpty()
  name!: string;
}
