-- AlterTable
ALTER TABLE "Address" ADD COLUMN     "toDelete" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Client" ADD COLUMN     "dataConsent" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "notified" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifiedMedia" TEXT NOT NULL DEFAULT 'email',
ADD COLUMN     "toDelete" BOOLEAN NOT NULL DEFAULT false;
