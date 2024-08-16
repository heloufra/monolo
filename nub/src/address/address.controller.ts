import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { AddressService } from './address.service';
import { CreateAddressDto } from './dto/create-address.dto';
import { UpdateAddressDto } from './dto/update-address.dto';
import { Roles } from 'src/common/role.decorator';

/*
    Prisma model to help me
    model Address {
      id           String      @id @default(cuid())
      name         String
      street       String
      city         String
      state        String
      country      String
      postalCode   String
      latitude     Float
      longitude    Float
      userId       String?
      user         User?       @relation(fields: [userId], references: [id])
      restaurantId String?
      restaurant   Restaurant? @relation(fields: [restaurantId], references: [id])
      createdAt    DateTime    @default(now())
      updatedAt    DateTime    @updatedAt
      @@map("addresses")
    }
 */

@Controller('address')
export class AddressController {
  constructor(private readonly addressService: AddressService) {}

  /**
   * 
   * @param createAddressDto 
   * @returns Address Entity
   * 
   *  create a new address record for the user
   */
  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Post()
  create(@Body() createAddressDto: CreateAddressDto) {
    return this.addressService.create(createAddressDto);
  }

  /**
   * 
   * @returns array of Address entity
   * 
   * get all addresses of the user
   */
  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get()
  findAll() {
    return this.addressService.findAll();
  }


  /**
   * 
   * @param id of address record
   * @returns Address entity
   */
  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.addressService.findOne(id);
  }


  /**
   * 
   * @param id of address record
   * @param updateAddressDto 
   * @returns new updated address entity
   */
  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateAddressDto: UpdateAddressDto) {
    return this.addressService.update(id, updateAddressDto);
  }

  /**
   * 
   * @param id of address record
   * @returns nothing
   */
  @Roles(['costumer', 'delivery_person', 'admin', 'restaurant'])
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.addressService.remove(id);
  }
}
