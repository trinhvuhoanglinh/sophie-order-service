/*
  Warnings:

  - You are about to drop the `SalesOrder2023` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SalesOrder2024` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SalesOrderItem2023` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SalesOrderItem2024` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "SalesOrderItem2023" DROP CONSTRAINT "SalesOrderItem2023_orderId_fkey";

-- DropForeignKey
ALTER TABLE "SalesOrderItem2024" DROP CONSTRAINT "SalesOrderItem2024_orderId_fkey";

-- DropTable
DROP TABLE "SalesOrder2023";

-- DropTable
DROP TABLE "SalesOrder2024";

-- DropTable
DROP TABLE "SalesOrderItem2023";

-- DropTable
DROP TABLE "SalesOrderItem2024";
