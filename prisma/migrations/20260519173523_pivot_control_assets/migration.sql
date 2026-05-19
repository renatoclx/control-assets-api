/*
  Warnings:

  - You are about to drop the column `type` on the `user_types` table. All the data in the column will be lost.
  - You are about to drop the column `schoolId` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `equipment_types` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `equipments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `schools` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `user_types` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `name` to the `user_types` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "AssetStatus" AS ENUM ('ATIVO', 'INATIVO', 'MANUTENCAO', 'CHAMADO', 'BAIXADO', 'ENVIADO', 'GARANTIA');

-- DropForeignKey
ALTER TABLE "equipments" DROP CONSTRAINT "equipments_brandId_fkey";

-- DropForeignKey
ALTER TABLE "equipments" DROP CONSTRAINT "equipments_equipmentTypeId_fkey";

-- DropForeignKey
ALTER TABLE "equipments" DROP CONSTRAINT "equipments_schoolId_fkey";

-- DropForeignKey
ALTER TABLE "schools" DROP CONSTRAINT "schools_cityId_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_schoolId_fkey";

-- DropIndex
DROP INDEX "user_types_type_key";

-- AlterTable
ALTER TABLE "user_types" DROP COLUMN "type",
ADD COLUMN     "name" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "schoolId",
ADD COLUMN     "departmentId" TEXT;

-- DropTable
DROP TABLE "equipment_types";

-- DropTable
DROP TABLE "equipments";

-- DropTable
DROP TABLE "schools";

-- DropEnum
DROP TYPE "EquipmentStatus";

-- CreateTable
CREATE TABLE "asset_types" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "asset_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "departments" (
    "id" TEXT NOT NULL,
    "reference" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "cityId" TEXT NOT NULL,

    CONSTRAINT "departments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "assets" (
    "id" TEXT NOT NULL,
    "patrimony" TEXT,
    "serial_number" TEXT,
    "description" TEXT,
    "status" "AssetStatus" NOT NULL DEFAULT 'ATIVO',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "brandId" TEXT NOT NULL,
    "assetTypeId" TEXT NOT NULL,
    "departmentId" TEXT NOT NULL,

    CONSTRAINT "assets_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "asset_types_name_key" ON "asset_types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "departments_reference_key" ON "departments"("reference");

-- CreateIndex
CREATE UNIQUE INDEX "assets_patrimony_key" ON "assets"("patrimony");

-- CreateIndex
CREATE UNIQUE INDEX "assets_serial_number_key" ON "assets"("serial_number");

-- CreateIndex
CREATE UNIQUE INDEX "user_types_name_key" ON "user_types"("name");

-- AddForeignKey
ALTER TABLE "departments" ADD CONSTRAINT "departments_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "cities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assets" ADD CONSTRAINT "assets_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "brands"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assets" ADD CONSTRAINT "assets_assetTypeId_fkey" FOREIGN KEY ("assetTypeId") REFERENCES "asset_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assets" ADD CONSTRAINT "assets_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE SET NULL ON UPDATE CASCADE;
