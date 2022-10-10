/*
  Warnings:

  - You are about to drop the column `image` on the `Category` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `Item` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `Public` table. All the data in the column will be lost.
  - Added the required column `imageUrl` to the `Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageUrl` to the `Item` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageUrl` to the `Public` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Category" DROP COLUMN "image",
ADD COLUMN     "imageUrl" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Item" DROP COLUMN "image",
ADD COLUMN     "imageUrl" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Public" DROP COLUMN "image",
ADD COLUMN     "imageUrl" TEXT NOT NULL;
