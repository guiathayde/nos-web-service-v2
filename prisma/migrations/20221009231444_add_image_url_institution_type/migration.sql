/*
  Warnings:

  - Added the required column `imageUrl` to the `InstitutionType` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "InstitutionType" ADD COLUMN     "imageUrl" TEXT NOT NULL;
