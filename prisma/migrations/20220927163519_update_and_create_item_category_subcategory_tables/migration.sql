/*
  Warnings:

  - You are about to drop the column `InstitutionAddressId` on the `Institution` table. All the data in the column will be lost.
  - You are about to drop the column `imageId` on the `Institution` table. All the data in the column will be lost.
  - You are about to drop the column `imageURL` on the `Institution` table. All the data in the column will be lost.
  - You are about to drop the column `legalInfoId` on the `Institution` table. All the data in the column will be lost.
  - You are about to drop the column `imageId` on the `Item` table. All the data in the column will be lost.
  - You are about to drop the column `imageURL` on the `Item` table. All the data in the column will be lost.
  - You are about to drop the column `institutionId` on the `Item` table. All the data in the column will be lost.
  - You are about to drop the `InstitutionAddress` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `LegalInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Search` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `StatusResult` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[publicId]` on the table `Institution` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `cnpj` to the `Institution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `corporateName` to the `Institution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `generalAddress` to the `Institution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lat` to the `Institution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lon` to the `Institution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `profileImage` to the `Institution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `publicId` to the `Institution` table without a default value. This is not possible if the table is not empty.
  - Added the required column `image` to the `Item` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Institution" DROP CONSTRAINT "Institution_InstitutionAddressId_fkey";

-- DropForeignKey
ALTER TABLE "Institution" DROP CONSTRAINT "Institution_legalInfoId_fkey";

-- DropForeignKey
ALTER TABLE "Item" DROP CONSTRAINT "Item_institutionId_fkey";

-- DropForeignKey
ALTER TABLE "Search" DROP CONSTRAINT "Search_federalId_fkey";

-- DropForeignKey
ALTER TABLE "Search" DROP CONSTRAINT "Search_laboristId_fkey";

-- DropForeignKey
ALTER TABLE "Search" DROP CONSTRAINT "Search_stageTwoId_fkey";

-- DropForeignKey
ALTER TABLE "Search" DROP CONSTRAINT "Search_stateId_fkey";

-- DropForeignKey
ALTER TABLE "Search" DROP CONSTRAINT "Search_unionId_fkey";

-- DropForeignKey
ALTER TABLE "StatusResult" DROP CONSTRAINT "StatusResult_searchId_fkey";

-- DropIndex
DROP INDEX "Institution_InstitutionAddressId_key";

-- DropIndex
DROP INDEX "Institution_legalInfoId_key";

-- AlterTable
ALTER TABLE "Institution" DROP COLUMN "InstitutionAddressId",
DROP COLUMN "imageId",
DROP COLUMN "imageURL",
DROP COLUMN "legalInfoId",
ADD COLUMN     "cnpj" TEXT NOT NULL,
ADD COLUMN     "corporateName" TEXT NOT NULL,
ADD COLUMN     "generalAddress" TEXT NOT NULL,
ADD COLUMN     "lat" TEXT NOT NULL,
ADD COLUMN     "lon" TEXT NOT NULL,
ADD COLUMN     "profileImage" TEXT NOT NULL,
ADD COLUMN     "publicId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Item" DROP COLUMN "imageId",
DROP COLUMN "imageURL",
DROP COLUMN "institutionId",
ADD COLUMN     "image" TEXT NOT NULL,
ADD COLUMN     "subcategoryId" TEXT;

-- AlterTable
ALTER TABLE "StageTwo" ADD COLUMN     "searchFederalResult" TEXT,
ADD COLUMN     "searchFederalStatus" INTEGER NOT NULL DEFAULT 2,
ADD COLUMN     "searchLaboristResult" TEXT,
ADD COLUMN     "searchLaboristStatus" INTEGER NOT NULL DEFAULT 2,
ADD COLUMN     "searchStateResult" TEXT,
ADD COLUMN     "searchStateStatus" INTEGER NOT NULL DEFAULT 2,
ADD COLUMN     "searchUnionResult" TEXT,
ADD COLUMN     "searchUnionStatus" INTEGER NOT NULL DEFAULT 2;

-- DropTable
DROP TABLE "InstitutionAddress";

-- DropTable
DROP TABLE "LegalInfo";

-- DropTable
DROP TABLE "Search";

-- DropTable
DROP TABLE "StatusResult";

-- CreateTable
CREATE TABLE "Subcategory" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "priority" INTEGER NOT NULL,
    "categoryId" TEXT,

    CONSTRAINT "Subcategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "priority" INTEGER NOT NULL,
    "image" TEXT NOT NULL,
    "backgroundColor" TEXT NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Public" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT NOT NULL,

    CONSTRAINT "Public_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CategoryToInstitution" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_InstitutionToItem" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Subcategory_categoryId_key" ON "Subcategory"("categoryId");

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToInstitution_AB_unique" ON "_CategoryToInstitution"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToInstitution_B_index" ON "_CategoryToInstitution"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_InstitutionToItem_AB_unique" ON "_InstitutionToItem"("A", "B");

-- CreateIndex
CREATE INDEX "_InstitutionToItem_B_index" ON "_InstitutionToItem"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Institution_publicId_key" ON "Institution"("publicId");

-- AddForeignKey
ALTER TABLE "Item" ADD CONSTRAINT "Item_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES "Subcategory"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subcategory" ADD CONSTRAINT "Subcategory_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Institution" ADD CONSTRAINT "Institution_publicId_fkey" FOREIGN KEY ("publicId") REFERENCES "Public"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToInstitution" ADD CONSTRAINT "_CategoryToInstitution_A_fkey" FOREIGN KEY ("A") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToInstitution" ADD CONSTRAINT "_CategoryToInstitution_B_fkey" FOREIGN KEY ("B") REFERENCES "Institution"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_InstitutionToItem" ADD CONSTRAINT "_InstitutionToItem_A_fkey" FOREIGN KEY ("A") REFERENCES "Institution"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_InstitutionToItem" ADD CONSTRAINT "_InstitutionToItem_B_fkey" FOREIGN KEY ("B") REFERENCES "Item"("id") ON DELETE CASCADE ON UPDATE CASCADE;
