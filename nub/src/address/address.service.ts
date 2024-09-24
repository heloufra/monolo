import { HttpException, Injectable } from '@nestjs/common';
import {
  AddressRegisterCoordinatesDto,
  AddressRegisterDto,
  CreateAddressCoordinatesDto,
  CreateAddressDto,
} from './dto/create-address.dto';
import { UpdateAddressDto } from './dto/update-address.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { GetCurrentUser } from 'src/common/user.decorator';

@Injectable()
export class AddressService {
  constructor(private readonly prismaService: PrismaService) {}

  async addressRegisterCoordinates(
    @GetCurrentUser() user: any,
    addressRegisterDto: AddressRegisterCoordinatesDto,
  ) {
    if (user.user_metadata.role === 'restaurant') {
      await this.prismaService.restaurant.update({
        where: {
          id: user.id,
        },
        data: {
          addresses: {
            create: addressRegisterDto.address,
          },
          phoneNumber: addressRegisterDto.phone,
        },
      });
    } else {
      await this.prismaService.user.update({
        where: {
          id: user.id,
        },
        data: {
          addresses: {
            create: addressRegisterDto.address,
          },
          phoneNumber: addressRegisterDto.phone,
        },
      });
    }
  }

  async addressRegister(
    @GetCurrentUser() user: any,
    addressRegisterDto: AddressRegisterDto,
  ) {
    const address = await this.prismaService.address.create({
      data: {
        ...addressRegisterDto.address,
      },
    });
    if (user.user_metadata.role === 'restaurant') {
      await this.prismaService.restaurant.update({
        where: {
          id: user.id,
        },
        data: {
          addresses: {
            connect: {
              id: address.id,
            },
          },
          phoneNumber: addressRegisterDto.phone,
        },
      });
    } else {
      await this.prismaService.user.update({
        where: {
          id: user.id,
        },
        data: {
          addresses: {
            connect: {
              id: address.id,
            },
          },
          phoneNumber: addressRegisterDto.phone,
        },
      });
      return await address;
    }
  }

  async create(user: any, createAddressDto: CreateAddressDto) {
    return await this.prismaService.address.create({
      data: {
        ...createAddressDto,
        user: {
          connect: {
<<<<<<< HEAD
            id: user.id,
=======
            id: user.id, 
>>>>>>> 40dcb1360f10cfe0b455ff94cd43e5f0f31e6b6f
          },
        },
      },
    });
  }

  async createCoordinates(
    user: any,
    createAddressDto: CreateAddressCoordinatesDto,
  ) {
    return await this.prismaService.address.create({
      data: {
        ...createAddressDto,
        user: {
          connect: {
            id: user.id,
<<<<<<< HEAD
          },
=======
          }
>>>>>>> 40dcb1360f10cfe0b455ff94cd43e5f0f31e6b6f
        },
      },
    });
  }

<<<<<<< HEAD
  async createWithId(
    user: any,
    createAddressDto: CreateAddressDto,
    id: string,
  ) {
=======
  async createWithId(user: any, createAddressDto: CreateAddressDto, id: string) {
>>>>>>> 40dcb1360f10cfe0b455ff94cd43e5f0f31e6b6f
    const usero = await this.prismaService.user.findUnique({
      where: {
        id: id,
      },
    });
<<<<<<< HEAD

=======
  
>>>>>>> 40dcb1360f10cfe0b455ff94cd43e5f0f31e6b6f
    if (!usero) {
      throw new HttpException('User not found', 404);
    }

<<<<<<< HEAD
=======


>>>>>>> 40dcb1360f10cfe0b455ff94cd43e5f0f31e6b6f
    return await this.prismaService.address.create({
      data: {
        ...createAddressDto,
        user: {
          connect: {
            id: id,
<<<<<<< HEAD
          },
=======
          }
>>>>>>> 40dcb1360f10cfe0b455ff94cd43e5f0f31e6b6f
        },
      },
    });
  }

  async findAll(user: any) {
    return await this.prismaService.address.findMany({
      where: {
        userId: user.id,
      },
    });
  }

  async findManyForUser(user: any, id: string) {
    if (user.id === id) {
      return await this.prismaService.address.findMany({
        where: {
          userId: id,
        },
      });
    }

    const userAddressRequested = await this.prismaService.user.findUnique({
      where: {
        id: id,
      },
    });

    if (!userAddressRequested) {
      throw new HttpException('User not found', 404);
    }

    if (userAddressRequested.role === 'RESTAURANT') {
      return await this.prismaService.address.findMany({
        where: {
          userId: id,
        },
      });
    }

    if (user.user_metadata.role === 'admin') {
      return await this.prismaService.address.findMany({
        where: {
          userId: id,
        },
      });
    }

    throw new HttpException('Unauthorized', 401);
  }

  async update(user: any, id: string, updateAddressDto: UpdateAddressDto) {
    const address = await this.prismaService.address.findUnique({
      where: {
        id: id,
      },
    });
    if (!address) {
      throw new HttpException('Address not found', 404);
    }

    if (user.id !== address.userId) {
      throw new HttpException('Unauthorized', 401);
    }

    const newAddress = await this.prismaService.address.update({
      where: {
        id: id,
        userId: user.id,
      },
      data: {
        ...updateAddressDto,
      },
    });

  

    return await newAddress;
  }

  async remove(user: any, id: string) {
    const address = await this.prismaService.address.findUnique({
      where: {
        id: id,
      },
    });

    if (address.userId !== user.id) {
      throw new HttpException('Unauthorized', 401);
    }

    await this.prismaService.address.delete({
      where: {
        id: id,
      },
    });
  }
}
