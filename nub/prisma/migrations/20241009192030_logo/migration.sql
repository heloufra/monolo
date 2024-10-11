/*
  Warnings:

  - You are about to drop the column `restaurantId` on the `addresses` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `restaurants` table. All the data in the column will be lost.
  - You are about to drop the column `picture` on the `restaurants` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[addressId]` on the table `restaurants` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `addressId` to the `restaurants` table without a default value. This is not possible if the table is not empty.
  - Made the column `email` on table `restaurants` required. This step will fail if there are existing NULL values in that column.
  - Made the column `phoneNumber` on table `restaurants` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "addresses" DROP CONSTRAINT "addresses_restaurantId_fkey";

-- AlterTable
ALTER TABLE "addresses" DROP COLUMN "restaurantId";

-- AlterTable
ALTER TABLE "restaurants" DROP COLUMN "address",
DROP COLUMN "picture",
ADD COLUMN     "addressId" TEXT NOT NULL,
ADD COLUMN     "logo" TEXT,
ADD COLUMN     "pictures" TEXT[],
ALTER COLUMN "email" SET NOT NULL,
ALTER COLUMN "phoneNumber" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "restaurants_addressId_key" ON "restaurants"("addressId");

-- AddForeignKey
ALTER TABLE "restaurants" ADD CONSTRAINT "restaurants_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "addresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
