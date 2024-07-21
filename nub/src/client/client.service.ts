// import { HttpException, Injectable } from '@nestjs/common';
// import { UpdateClientDto } from './dto/update-client.dto';
// import { PrismaService } from 'src/prisma/prisma.service';
// import { JwtPayload } from 'src/auth/entities/jwt.entity';
// import { AddressDto, AddressRegisterDto } from './dto/address-register.dto';
// import { DataCollectionDto } from './dto/data-collection.dto';
// import { NotificationDto } from './dto/notif.dto';

// @Injectable()
// export class ClientService {
//   constructor (private readonly prismaService: PrismaService) {}
  
//   async getAddress(user: JwtPayload) {
//     const userAddress = await this.prismaService.client.findUnique({
//       where: {
//         email: user.email
//       },
//       select: {
//         address: true
//       }
//     });

//     return userAddress.address.map((address) => { return { id: address.id, name: address.name, address: address.address } });
//   }

//   async newAddress(user: JwtPayload, address: AddressDto) {
//     await this.prismaService.client.update({
//       where: {
//         email: user.email
//       },
//       data: {
//         address: {
//           create: {
//             address: address.address,
//             name: address.name
//           }
//         }
//       }
//     });
//   }

//   async newAddressRegister(user: JwtPayload, addressRegisterDto: AddressRegisterDto) {
//       await this.prismaService.client.update({
//         where: {
//           email: user.email
//         },
//         data: {
//           phone: addressRegisterDto.phone,
//           address: {
//             create: {
//               address: addressRegisterDto.address,
//               name: addressRegisterDto.name,
//             }
//           }
//         }
//       });
 
//   }
//   // create(createClientDto: CreateClientDto) {
//   //   // create user in db using prisma
//   //   return this.prismaService.client.create({
//   //     data: createClientDto
//   //   });
//   // }

//   async updateAddress (id: string, user: JwtPayload, addressRegisterDto: AddressRegisterDto) {
//     // check if the address exists and belongs to the user
//     // if yes, update the address
//     const address = await this.prismaService.address.findFirst({
//       where: {
//         id: id,
//         clientId: user.sub
//       }
//     });

//     if (!address) {
//       throw new HttpException('Address not found', 404);
//     }

//     return this.prismaService.address.update({
//       where: {
//         id: id
//       },
//       data: {
//         name: addressRegisterDto.name,
//         address: addressRegisterDto.address
//       },
//       select: {
//         id: true,
//         name: true,
//         address: true
//       }
//     });
//   }

//   async deleteAddress (id: string, user: JwtPayload) {
//     // check if the address exists and belongs to the user
//     // if yes, delete the address
//     const address = await this.prismaService.address.findFirst({
//       where: {
//         id: id,
//         clientId: user.sub
//       }
//     });

//     if (!address) {
//       throw new HttpException('Address not found', 404);
//     }

//     this.prismaService.address.update({
//       where: {
//         id: id
//       },
//       data: {
//         toDelete: true
//       }
//     });
//   }

//   async deleteClient (user: JwtPayload) {
//     // check if the user exists and is not set to be deleted
//     // if yes, set the user to be deleted
//     const client = await this.prismaService.client.findUnique({
//       where: {
//         email: user.email,
//         toDelete: false
//       }
//     });

//     if (!client) {
//       throw new HttpException('User not found', 404);
//     }

//     this.prismaService.client.delete({
//       where: {
//         email: user.email
//       }
//     });
//   }

//   async dataCollection (user: JwtPayload, dataConsent: DataCollectionDto) {
//     // check if the user exists and is not set to be deleted
//     // if yes, set the user to be deleted
//     const client = await this.prismaService.client.findUnique({
//       where: {
//         email: user.email,
//         toDelete: false
//       }
//     });

//     if (!client) {
//       throw new HttpException('User not found', 404);
//     }

//     this.prismaService.client.update({
//       where: {
//         email: user.email
//       },
//       data: {
//         dataConsent: dataConsent.enable
//       }
//     });
//   }

//   async updateNotification (user: JwtPayload, notification: NotificationDto) {
//     // check if the user exists and is not set to be deleted
//     // if yes, set the user to be deleted
//     const client = await this.prismaService.client.findUnique({
//       where: {
//         email: user.email,
//         toDelete: false
//       }
//     });

//     if (!client) {
//       throw new HttpException('User not found', 404);
//     }
//     console.log('notification', notification);
//     await this.prismaService.client.update({
//       where: {
//         email: user.email
//       },
//       data: {
//         notified: notification.enable,
//         notifiedMedia: notification.preference
//       }
//     });
//   }

//   async update (user: JwtPayload, updateClientDto: UpdateClientDto) {
//     // check if the user exists and is not set to be deleted
//     // if yes, update the user
//     const client = await this.prismaService.client.findUnique({
//       where: {
//         email: user.email,
//         toDelete: false
//       }
//     });

//     if (!client) {
//       throw new HttpException('User not found', 404);
//     }

//     await this.prismaService.client.update({
//       where: {
//         email: user.email
//       },
//       data: {
//         name: updateClientDto.name,
//         email: updateClientDto.email,
//         phone: updateClientDto.phone
//       }
//     });
//   }

//   async getProfile (user: JwtPayload) {
//     // check if the user exists and is not set to be deleted
//     // if yes, return the user
//     console.log('user', user);
//     const client = await this.prismaService.client.findUnique({
//       where: {
//         email: user.email,
//         toDelete: false
//       },
//       select: {
//         name: true,
//         email: true,
//         phone: true,
//         address: true,
//         dataConsent: true,
//         notified: true,
//         notifiedMedia: true
//       }
//     });

//     if (!client) {
//       throw new HttpException('User not found', 404);
//     }

//     return client;
//   }
// }
