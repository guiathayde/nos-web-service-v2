/*
  Warnings:

  - You are about to drop the column `institutionId` on the `InstitutionVerification` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[institutionVerificationId]` on the table `Institution` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `institutionVerificationId` to the `Institution` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "InstitutionVerification" DROP CONSTRAINT "InstitutionVerification_institutionId_fkey";

-- DropIndex
DROP INDEX "InstitutionVerification_institutionId_key";

-- AlterTable
ALTER TABLE "Institution" ADD COLUMN     "institutionVerificationId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "InstitutionVerification" DROP COLUMN "institutionId";

-- CreateIndex
CREATE UNIQUE INDEX "Institution_institutionVerificationId_key" ON "Institution"("institutionVerificationId");

-- AddForeignKey
ALTER TABLE "Institution" ADD CONSTRAINT "Institution_institutionVerificationId_fkey" FOREIGN KEY ("institutionVerificationId") REFERENCES "InstitutionVerification"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
