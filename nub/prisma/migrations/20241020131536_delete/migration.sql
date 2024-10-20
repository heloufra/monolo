-- AlterTable
ALTER TABLE "users" ADD COLUMN     "deleted" BOOLEAN DEFAULT false,
ADD COLUMN     "deletedAt" TIMESTAMP(3);
