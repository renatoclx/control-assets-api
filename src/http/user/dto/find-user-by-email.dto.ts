import { IsEmail, IsNotEmpty } from 'class-validator';

export class FindUserByEmailDTO {
  @IsEmail()
  @IsNotEmpty()
  email!: string;
}
