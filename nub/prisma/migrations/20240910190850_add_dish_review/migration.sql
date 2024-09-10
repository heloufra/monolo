-- AlterTable
ALTER TABLE "reviews" ADD COLUMN     "dishId" TEXT;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "dishes"("id") ON DELETE SET NULL ON UPDATE CASCADE;
