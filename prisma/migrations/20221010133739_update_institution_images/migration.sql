/*
  Warnings:

  - Added the required column `profileImageId` to the `Institution` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Institution" ADD COLUMN     "galleryImagesIds" TEXT[],
ADD COLUMN     "profileImageId" TEXT NOT NULL;
