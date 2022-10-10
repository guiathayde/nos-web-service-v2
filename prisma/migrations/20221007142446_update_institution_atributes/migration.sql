/*
  Warnings:

  - You are about to drop the column `galleryImages` on the `Institution` table. All the data in the column will be lost.
  - You are about to drop the column `profileImage` on the `Institution` table. All the data in the column will be lost.
  - Added the required column `profileImageUrl` to the `Institution` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Institution" DROP COLUMN "galleryImages",
DROP COLUMN "profileImage",
ADD COLUMN     "galleryImagesUrls" TEXT[],
ADD COLUMN     "profileImageUrl" TEXT NOT NULL,
ALTER COLUMN "isVerified" SET DEFAULT false;
