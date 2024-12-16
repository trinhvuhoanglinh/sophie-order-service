-- CreateTable
CREATE TABLE "SalesOrder2022" (
    "id" SERIAL NOT NULL,
    "orderId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "grandTotal" DOUBLE PRECISION NOT NULL,
    "grandTotalIncTax" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "SalesOrder2022_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalesOrderItem2022" (
    "id" SERIAL NOT NULL,
    "itemId" TEXT NOT NULL,
    "orderId" INTEGER NOT NULL,
    "sku" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "priceIncTax" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "SalesOrderItem2022_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "SalesOrder2022_orderId_key" ON "SalesOrder2022"("orderId");

-- CreateIndex
CREATE UNIQUE INDEX "SalesOrderItem2022_itemId_key" ON "SalesOrderItem2022"("itemId");

-- AddForeignKey
ALTER TABLE "SalesOrderItem2022" ADD CONSTRAINT "SalesOrderItem2022_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "SalesOrder2022"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
