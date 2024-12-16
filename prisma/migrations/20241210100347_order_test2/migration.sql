/*
  Warnings:

  - The primary key for the `SalesOrder2023` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `orderIncrementId` column on the `SalesOrder2023` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `SalesOrder2024` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `orderIncrementId` column on the `SalesOrder2024` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- DropForeignKey
ALTER TABLE "SalesOrderItem2023" DROP CONSTRAINT "SalesOrderItem2023_orderId_fkey";

-- DropForeignKey
ALTER TABLE "SalesOrderItem2024" DROP CONSTRAINT "SalesOrderItem2024_orderId_fkey";

-- AlterTable
ALTER TABLE "SalesOrder2023" DROP CONSTRAINT "SalesOrder2023_pkey",
ALTER COLUMN "id" SET DEFAULT (EXTRACT(EPOCH FROM now()) * 1000)::BIGINT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE BIGINT,
DROP COLUMN "orderIncrementId",
ADD COLUMN     "orderIncrementId" SERIAL NOT NULL,
ADD CONSTRAINT "SalesOrder2023_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "SalesOrder2023_id_seq";

-- AlterTable
ALTER TABLE "SalesOrder2024" DROP CONSTRAINT "SalesOrder2024_pkey",
ALTER COLUMN "id" SET DEFAULT (EXTRACT(EPOCH FROM now()) * 1000)::BIGINT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE BIGINT,
DROP COLUMN "orderIncrementId",
ADD COLUMN     "orderIncrementId" SERIAL NOT NULL,
ADD CONSTRAINT "SalesOrder2024_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "SalesOrder2024_id_seq";

-- AlterTable
ALTER TABLE "SalesOrderItem2023" ALTER COLUMN "orderId" SET DATA TYPE BIGINT;

-- AlterTable
ALTER TABLE "SalesOrderItem2024" ALTER COLUMN "orderId" SET DATA TYPE BIGINT;

-- AddForeignKey
ALTER TABLE "SalesOrderItem2023" ADD CONSTRAINT "SalesOrderItem2023_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "SalesOrder2023"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalesOrderItem2024" ADD CONSTRAINT "SalesOrderItem2024_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "SalesOrder2024"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
