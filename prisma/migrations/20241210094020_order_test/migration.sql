-- CreateTable
CREATE TABLE "SalesOrder2023" (
    "id" SERIAL NOT NULL,
    "orderIncrementId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "grandTotal" DOUBLE PRECISION NOT NULL,
    "grandTotalIncTax" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "SalesOrder2023_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalesOrderItem2023" (
    "itemId" SERIAL NOT NULL,
    "orderId" INTEGER NOT NULL,
    "sku" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "priceIncTax" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "SalesOrderItem2023_pkey" PRIMARY KEY ("itemId")
);

-- CreateTable
CREATE TABLE "SalesOrder2024" (
    "id" SERIAL NOT NULL,
    "orderIncrementId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "grandTotal" DOUBLE PRECISION NOT NULL,
    "grandTotalIncTax" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "SalesOrder2024_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalesOrderItem2024" (
    "itemId" SERIAL NOT NULL,
    "orderId" INTEGER NOT NULL,
    "sku" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "priceIncTax" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "SalesOrderItem2024_pkey" PRIMARY KEY ("itemId")
);

-- AddForeignKey
ALTER TABLE "SalesOrderItem2023" ADD CONSTRAINT "SalesOrderItem2023_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "SalesOrder2023"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalesOrderItem2024" ADD CONSTRAINT "SalesOrderItem2024_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "SalesOrder2024"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
