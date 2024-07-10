/*
  Warnings:

  - Added the required column `address` to the `Address` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Address" ADD COLUMN     "address" TEXT NOT NULL,
ALTER COLUMN "street" DROP NOT NULL,
ALTER COLUMN "city" DROP NOT NULL,
ALTER COLUMN "country" DROP NOT NULL,
ALTER COLUMN "zip" DROP NOT NULL;
