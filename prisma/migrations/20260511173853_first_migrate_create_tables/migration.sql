-- CreateEnum
CREATE TYPE "EquipmentStatus" AS ENUM ('ATIVO', 'INATIVO', 'MANUTENCAO', 'CHAMADO', 'BAIXADO', 'ENVIADO', 'DIRETORIA');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ATIVO', 'INATIVO', 'SUSPENSO');

-- CreateTable
CREATE TABLE "cities" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "brands" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "brands_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_types" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "user_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "equipment_types" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "equipment_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "schools" (
    "id" TEXT NOT NULL,
    "cie" TEXT,
    "name" TEXT NOT NULL,
    "adress" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "cityId" TEXT NOT NULL,

    CONSTRAINT "schools_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "equipments" (
    "id" TEXT NOT NULL,
    "patrimony" TEXT,
    "serial_number" TEXT,
    "description" TEXT,
    "status" "EquipmentStatus" NOT NULL DEFAULT 'ATIVO',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "brandId" TEXT NOT NULL,
    "equipmentTypeId" TEXT NOT NULL,
    "schoolId" TEXT NOT NULL,

    CONSTRAINT "equipments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "document" TEXT,
    "address" TEXT,
    "status" "UserStatus" NOT NULL DEFAULT 'ATIVO',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "userTypeId" TEXT NOT NULL,
    "cityId" TEXT NOT NULL,
    "schoolId" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "cities_name_key" ON "cities"("name");

-- CreateIndex
CREATE UNIQUE INDEX "brands_name_key" ON "brands"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_types_type_key" ON "user_types"("type");

-- CreateIndex
CREATE UNIQUE INDEX "equipment_types_type_key" ON "equipment_types"("type");

-- CreateIndex
CREATE UNIQUE INDEX "schools_cie_key" ON "schools"("cie");

-- CreateIndex
CREATE UNIQUE INDEX "equipments_patrimony_key" ON "equipments"("patrimony");

-- CreateIndex
CREATE UNIQUE INDEX "equipments_serial_number_key" ON "equipments"("serial_number");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_document_key" ON "users"("document");

-- AddForeignKey
ALTER TABLE "schools" ADD CONSTRAINT "schools_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "cities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipments" ADD CONSTRAINT "equipments_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "brands"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipments" ADD CONSTRAINT "equipments_equipmentTypeId_fkey" FOREIGN KEY ("equipmentTypeId") REFERENCES "equipment_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipments" ADD CONSTRAINT "equipments_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "schools"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_userTypeId_fkey" FOREIGN KEY ("userTypeId") REFERENCES "user_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "cities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_schoolId_fkey" FOREIGN KEY ("schoolId") REFERENCES "schools"("id") ON DELETE SET NULL ON UPDATE CASCADE;
