/*
  Warnings:

  - The `status` column on the `orders` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `notificationPreference` column on the `settings` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `role` column on the `users` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "userrole" AS ENUM ('CUSTOMER', 'DELIVERY_PERSON', 'ADMIN');

-- CreateEnum
CREATE TYPE "orderstatus" AS ENUM ('PENDING', 'CONFIRMED', 'PREPARING', 'OUT_FOR_DELIVERY', 'DELIVERED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "notificationpreference" AS ENUM ('EMAIL', 'SMS', 'NONE');

-- AlterTable
ALTER TABLE "orders" DROP COLUMN "status",
ADD COLUMN     "status" "orderstatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "settings" DROP COLUMN "notificationPreference",
ADD COLUMN     "notificationPreference" "notificationpreference" NOT NULL DEFAULT 'EMAIL';

-- AlterTable
ALTER TABLE "users" DROP COLUMN "role",
ADD COLUMN     "role" "userrole" NOT NULL DEFAULT 'CUSTOMER';

-- DropEnum
DROP TYPE "NotificationPreference";

-- DropEnum
DROP TYPE "OrderStatus";

-- DropEnum
DROP TYPE "UserRole";
