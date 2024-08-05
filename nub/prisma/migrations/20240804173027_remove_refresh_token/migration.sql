/*
  Warnings:

  - You are about to drop the column `refreshToken` on the `restaurants` table. All the data in the column will be lost.
  - You are about to drop the column `refreshToken` on the `users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "restaurants" DROP COLUMN "refreshToken";

-- AlterTable
ALTER TABLE "users" DROP COLUMN "refreshToken";
