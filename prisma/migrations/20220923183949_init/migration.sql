-- CreateTable
CREATE TABLE "InstitutionAddress" (
    "id" TEXT NOT NULL,
    "generalAddress" TEXT NOT NULL,
    "lat" TEXT NOT NULL,
    "lon" TEXT NOT NULL,

    CONSTRAINT "InstitutionAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Item" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "imageId" TEXT NOT NULL,
    "imageURL" TEXT NOT NULL,
    "subcategory" TEXT NOT NULL,
    "priority" INTEGER NOT NULL,
    "institutionId" TEXT,

    CONSTRAINT "Item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LegalInfo" (
    "id" TEXT NOT NULL,
    "corporateName" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,

    CONSTRAINT "LegalInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Institution" (
    "id" TEXT NOT NULL,
    "deliverInfo" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "imageId" TEXT NOT NULL,
    "imageURL" TEXT NOT NULL,
    "galleryImages" TEXT[],
    "InstitutionAddressId" TEXT NOT NULL,
    "institutionName" TEXT NOT NULL,
    "institutionPhone" INTEGER NOT NULL,
    "institutionType" TEXT NOT NULL,
    "publicTypeId" TEXT NOT NULL,
    "quantity" TEXT NOT NULL,
    "responsiblePersonEmail" TEXT NOT NULL,
    "responsiblePersonName" TEXT NOT NULL,
    "responsiblePersonPhone" TEXT NOT NULL,
    "site" TEXT NOT NULL,
    "workingDays" TEXT NOT NULL,
    "bankInfo" TEXT NOT NULL,
    "customNeed" TEXT NOT NULL,
    "customService" TEXT NOT NULL,
    "crowdfunding" TEXT NOT NULL,
    "legalInfoId" TEXT NOT NULL,
    "isVerified" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Institution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "role" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Institution_InstitutionAddressId_key" ON "Institution"("InstitutionAddressId");

-- CreateIndex
CREATE UNIQUE INDEX "Institution_legalInfoId_key" ON "Institution"("legalInfoId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Item" ADD CONSTRAINT "Item_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "Institution"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Institution" ADD CONSTRAINT "Institution_InstitutionAddressId_fkey" FOREIGN KEY ("InstitutionAddressId") REFERENCES "InstitutionAddress"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Institution" ADD CONSTRAINT "Institution_legalInfoId_fkey" FOREIGN KEY ("legalInfoId") REFERENCES "LegalInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
