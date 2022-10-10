/*
  Warnings:

  - Added the required column `imageId` to the `Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageId` to the `InstitutionType` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageId` to the `Item` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageId` to the `Public` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Category" ADD COLUMN     "imageId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "InstitutionType" ADD COLUMN     "imageId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Item" ADD COLUMN     "imageId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Public" ADD COLUMN     "imageId" TEXT NOT NULL;
