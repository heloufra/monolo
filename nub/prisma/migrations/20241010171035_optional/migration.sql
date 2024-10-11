-- DropForeignKey
ALTER TABLE "restaurants" DROP CONSTRAINT "restaurants_addressId_fkey";

-- AlterTable
ALTER TABLE "restaurants" ALTER COLUMN "phoneNumber" DROP NOT NULL,
ALTER COLUMN "addressId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "restaurants" ADD CONSTRAINT "restaurants_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE;
