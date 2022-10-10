/*
  Warnings:

  - You are about to drop the column `stageOneId` on the `InstitutionVerification` table. All the data in the column will be lost.
  - You are about to drop the column `stageThreeId` on the `InstitutionVerification` table. All the data in the column will be lost.
  - You are about to drop the column `stageTwoId` on the `InstitutionVerification` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[institutionVerificationId]` on the table `StaegeThree` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[institutionVerificationId]` on the table `StageOne` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[institutionVerificationId]` on the table `StageTwo` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `institutionVerificationId` to the `StaegeThree` table without a default value. This is not possible if the table is not empty.
  - Added the required column `institutionVerificationId` to the `StageOne` table without a default value. This is not possible if the table is not empty.
  - Added the required column `institutionVerificationId` to the `StageTwo` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "InstitutionVerification" DROP CONSTRAINT "InstitutionVerification_stageOneId_fkey";

-- DropForeignKey
ALTER TABLE "InstitutionVerification" DROP CONSTRAINT "InstitutionVerification_stageThreeId_fkey";

-- DropForeignKey
ALTER TABLE "InstitutionVerification" DROP CONSTRAINT "InstitutionVerification_stageTwoId_fkey";

-- DropIndex
DROP INDEX "InstitutionVerification_stageOneId_key";

-- DropIndex
DROP INDEX "InstitutionVerification_stageThreeId_key";

-- DropIndex
DROP INDEX "InstitutionVerification_stageTwoId_key";

-- AlterTable
ALTER TABLE "InstitutionVerification" DROP COLUMN "stageOneId",
DROP COLUMN "stageThreeId",
DROP COLUMN "stageTwoId";

-- AlterTable
ALTER TABLE "StaegeThree" ADD COLUMN     "institutionVerificationId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "StageOne" ADD COLUMN     "institutionVerificationId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "StageTwo" ADD COLUMN     "institutionVerificationId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "StaegeThree_institutionVerificationId_key" ON "StaegeThree"("institutionVerificationId");

-- CreateIndex
CREATE UNIQUE INDEX "StageOne_institutionVerificationId_key" ON "StageOne"("institutionVerificationId");

-- CreateIndex
CREATE UNIQUE INDEX "StageTwo_institutionVerificationId_key" ON "StageTwo"("institutionVerificationId");

-- AddForeignKey
ALTER TABLE "StageOne" ADD CONSTRAINT "StageOne_institutionVerificationId_fkey" FOREIGN KEY ("institutionVerificationId") REFERENCES "InstitutionVerification"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StageTwo" ADD CONSTRAINT "StageTwo_institutionVerificationId_fkey" FOREIGN KEY ("institutionVerificationId") REFERENCES "InstitutionVerification"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaegeThree" ADD CONSTRAINT "StaegeThree_institutionVerificationId_fkey" FOREIGN KEY ("institutionVerificationId") REFERENCES "InstitutionVerification"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
