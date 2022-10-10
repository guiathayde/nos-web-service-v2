/*
  Warnings:

  - You are about to drop the column `institutionType` on the `Institution` table. All the data in the column will be lost.
  - You are about to drop the column `publicId` on the `Institution` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[publicTypeId]` on the table `Institution` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[institutionTypeId]` on the table `Institution` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[institutionId]` on the table `InstitutionVerification` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `institutionTypeId` to the `Institution` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Institution" DROP CONSTRAINT "Institution_publicId_fkey";

-- DropIndex
DROP INDEX "Institution_publicId_key";

-- AlterTable
ALTER TABLE "Institution" DROP COLUMN "institutionType",
DROP COLUMN "publicId",
ADD COLUMN     "institutionTypeId" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "InstitutionType" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "InstitutionType_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Institution_publicTypeId_key" ON "Institution"("publicTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "Institution_institutionTypeId_key" ON "Institution"("institutionTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "InstitutionVerification_institutionId_key" ON "InstitutionVerification"("institutionId");

-- AddForeignKey
ALTER TABLE "Institution" ADD CONSTRAINT "Institution_publicTypeId_fkey" FOREIGN KEY ("publicTypeId") REFERENCES "Public"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Institution" ADD CONSTRAINT "Institution_institutionTypeId_fkey" FOREIGN KEY ("institutionTypeId") REFERENCES "InstitutionType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
