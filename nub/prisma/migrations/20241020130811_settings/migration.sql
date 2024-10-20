/*
  Warnings:

  - You are about to drop the column `enableDataCollection` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `notificationPreference` on the `settings` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "settings" DROP COLUMN "enableDataCollection",
DROP COLUMN "notificationPreference",
ADD COLUMN     "dataSharingEnabled" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "deliveryStatus" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "emailNotifications" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "locationEnabled" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "orderUpdates" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "promotions" BOOLEAN NOT NULL DEFAULT true;
