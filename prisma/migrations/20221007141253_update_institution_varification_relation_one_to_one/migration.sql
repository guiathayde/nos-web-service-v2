/*
  Warnings:

  - You are about to drop the column `institutionVerificationId` on the `Institution` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[institutionId]` on the table `InstitutionVerification` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `institutionId` to the `InstitutionVerification` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Institution" DROP CONSTRAINT "Institution_institutionVerificationId_fkey";

-- DropIndex
DROP INDEX "Institution_institutionVerificationId_key";

-- AlterTable
ALTER TABLE "Institution" DROP COLUMN "institutionVerificationId";

-- AlterTable
ALTER TABLE "InstitutionVerification" ADD COLUMN     "institutionId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "InstitutionVerification_institutionId_key" ON "InstitutionVerification"("institutionId");

-- AddForeignKey
ALTER TABLE "InstitutionVerification" ADD CONSTRAINT "InstitutionVerification_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "Institution"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
