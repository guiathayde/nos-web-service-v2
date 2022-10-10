-- CreateTable
CREATE TABLE "StageOne" (
    "id" TEXT NOT NULL,
    "responsibleUserId" TEXT,
    "date" TIMESTAMP(3),
    "notes" TEXT,
    "status" INTEGER NOT NULL DEFAULT 2,

    CONSTRAINT "StageOne_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StatusResult" (
    "id" TEXT NOT NULL,
    "searchId" TEXT NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 2,
    "result" TEXT,

    CONSTRAINT "StatusResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Search" (
    "id" TEXT NOT NULL,
    "stageTwoId" TEXT NOT NULL,
    "stateId" TEXT NOT NULL,
    "federalId" TEXT NOT NULL,
    "laboristId" TEXT NOT NULL,
    "unionId" TEXT NOT NULL,

    CONSTRAINT "Search_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StageTwo" (
    "id" TEXT NOT NULL,
    "responsibleUserId" TEXT,
    "date" TIMESTAMP(3),
    "notes" TEXT,
    "status" INTEGER NOT NULL DEFAULT 2,

    CONSTRAINT "StageTwo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaegeThree" (
    "id" TEXT NOT NULL,
    "responsibleUserId" TEXT,
    "date" TIMESTAMP(3),
    "notes" TEXT,
    "status" INTEGER NOT NULL DEFAULT 2,
    "stageOneReview" BOOLEAN NOT NULL DEFAULT false,
    "stageTwoReview" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "StaegeThree_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InstitutionVerification" (
    "id" TEXT NOT NULL,
    "institutionId" TEXT NOT NULL,
    "stageOneId" TEXT NOT NULL,
    "stageTwoId" TEXT NOT NULL,
    "stageThreeId" TEXT NOT NULL,

    CONSTRAINT "InstitutionVerification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "StageOne_responsibleUserId_key" ON "StageOne"("responsibleUserId");

-- CreateIndex
CREATE UNIQUE INDEX "StatusResult_searchId_key" ON "StatusResult"("searchId");

-- CreateIndex
CREATE UNIQUE INDEX "Search_stageTwoId_key" ON "Search"("stageTwoId");

-- CreateIndex
CREATE UNIQUE INDEX "Search_stateId_key" ON "Search"("stateId");

-- CreateIndex
CREATE UNIQUE INDEX "Search_federalId_key" ON "Search"("federalId");

-- CreateIndex
CREATE UNIQUE INDEX "Search_laboristId_key" ON "Search"("laboristId");

-- CreateIndex
CREATE UNIQUE INDEX "Search_unionId_key" ON "Search"("unionId");

-- CreateIndex
CREATE UNIQUE INDEX "StageTwo_responsibleUserId_key" ON "StageTwo"("responsibleUserId");

-- CreateIndex
CREATE UNIQUE INDEX "StaegeThree_responsibleUserId_key" ON "StaegeThree"("responsibleUserId");

-- CreateIndex
CREATE UNIQUE INDEX "InstitutionVerification_stageOneId_key" ON "InstitutionVerification"("stageOneId");

-- CreateIndex
CREATE UNIQUE INDEX "InstitutionVerification_stageTwoId_key" ON "InstitutionVerification"("stageTwoId");

-- CreateIndex
CREATE UNIQUE INDEX "InstitutionVerification_stageThreeId_key" ON "InstitutionVerification"("stageThreeId");

-- AddForeignKey
ALTER TABLE "StageOne" ADD CONSTRAINT "StageOne_responsibleUserId_fkey" FOREIGN KEY ("responsibleUserId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StatusResult" ADD CONSTRAINT "StatusResult_searchId_fkey" FOREIGN KEY ("searchId") REFERENCES "Search"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_stageTwoId_fkey" FOREIGN KEY ("stageTwoId") REFERENCES "StageTwo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "StatusResult"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_federalId_fkey" FOREIGN KEY ("federalId") REFERENCES "StatusResult"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_laboristId_fkey" FOREIGN KEY ("laboristId") REFERENCES "StatusResult"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_unionId_fkey" FOREIGN KEY ("unionId") REFERENCES "StatusResult"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StageTwo" ADD CONSTRAINT "StageTwo_responsibleUserId_fkey" FOREIGN KEY ("responsibleUserId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaegeThree" ADD CONSTRAINT "StaegeThree_responsibleUserId_fkey" FOREIGN KEY ("responsibleUserId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstitutionVerification" ADD CONSTRAINT "InstitutionVerification_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "Institution"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstitutionVerification" ADD CONSTRAINT "InstitutionVerification_stageOneId_fkey" FOREIGN KEY ("stageOneId") REFERENCES "StageOne"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstitutionVerification" ADD CONSTRAINT "InstitutionVerification_stageTwoId_fkey" FOREIGN KEY ("stageTwoId") REFERENCES "StageTwo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstitutionVerification" ADD CONSTRAINT "InstitutionVerification_stageThreeId_fkey" FOREIGN KEY ("stageThreeId") REFERENCES "StaegeThree"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
