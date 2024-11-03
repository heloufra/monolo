-- CreateEnum
CREATE TYPE "userrole" AS ENUM ('CUSTOMER', 'DELIVERY_PERSON', 'ADMIN');

-- CreateEnum
CREATE TYPE "orderstatus" AS ENUM ('PENDING', 'CONFIRMED', 'PREPARING', 'READY_FOR_PICKUP', 'IN_DELIVERY', 'DELIVERED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "DeliveryStatus" AS ENUM ('PENDING', 'ASSIGNED', 'PICKED_UP', 'DELIVERED', 'FAILED');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('CREDIT_CARD', 'DEBIT_CARD', 'DIGITAL_WALLET', 'CASH');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "roles" "userrole" NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "userprofiles" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "dateOfBirth" TIMESTAMP(3),
    "avatarUrl" TEXT,
    "userId" TEXT NOT NULL,

    CONSTRAINT "userprofiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "settings" (
    "id" TEXT NOT NULL,
    "darkMode" BOOLEAN NOT NULL DEFAULT false,
    "locationEnabled" BOOLEAN NOT NULL DEFAULT false,
    "dataSharingEnabled" BOOLEAN NOT NULL DEFAULT true,
    "orderUpdates" BOOLEAN NOT NULL DEFAULT true,
    "promotions" BOOLEAN NOT NULL DEFAULT true,
    "deliveryStatus" BOOLEAN NOT NULL DEFAULT true,
    "emailNotifications" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "userId" TEXT NOT NULL,

    CONSTRAINT "settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurants" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT NOT NULL,
    "rating" DOUBLE PRECISION,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "restaurants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurantprofiles" (
    "id" TEXT NOT NULL,
    "logoUrl" TEXT,
    "pictures" TEXT[],
    "description" TEXT,
    "restaurantId" TEXT NOT NULL,

    CONSTRAINT "restaurantprofiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurantaddresses" (
    "id" TEXT NOT NULL,
    "street" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "zipCode" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "restaurantId" TEXT NOT NULL,

    CONSTRAINT "restaurantaddresses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workinghours" (
    "id" TEXT NOT NULL,
    "dayOfWeek" INTEGER NOT NULL,
    "openTime" TEXT NOT NULL,
    "closeTime" TEXT NOT NULL,
    "restaurantId" TEXT NOT NULL,

    CONSTRAINT "workinghours_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menucategories" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "avatarUrl" TEXT,
    "restaurantId" TEXT NOT NULL,

    CONSTRAINT "menucategories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menuitems" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "pictures" TEXT[],
    "description" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "image" TEXT,
    "isAvailable" BOOLEAN NOT NULL DEFAULT true,
    "categoryId" TEXT NOT NULL,

    CONSTRAINT "menuitems_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" TEXT NOT NULL,
    "orderNumber" TEXT NOT NULL,
    "status" "orderstatus" NOT NULL,
    "subtotal" DECIMAL(10,2) NOT NULL,
    "tax" DECIMAL(10,2) NOT NULL,
    "deliveryFee" DECIMAL(10,2) NOT NULL,
    "total" DECIMAL(10,2) NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "customerId" TEXT NOT NULL,
    "restaurantId" TEXT NOT NULL,
    "addressId" TEXT NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orderitems" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unitPrice" DECIMAL(10,2) NOT NULL,
    "totalPrice" DECIMAL(10,2) NOT NULL,
    "notes" TEXT,
    "orderId" TEXT NOT NULL,
    "menuItemId" TEXT NOT NULL,

    CONSTRAINT "orderitems_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deliveries" (
    "id" TEXT NOT NULL,
    "status" "DeliveryStatus" NOT NULL,
    "pickupTime" TIMESTAMP(3),
    "deliveredTime" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderId" TEXT NOT NULL,
    "driverId" TEXT NOT NULL,

    CONSTRAINT "deliveries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" TEXT NOT NULL,
    "street" TEXT,
    "city" TEXT,
    "state" TEXT,
    "zipCode" TEXT,
    "country" TEXT,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" TEXT NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "status" "PaymentStatus" NOT NULL,
    "provider" TEXT NOT NULL,
    "paymentMethod" "PaymentMethod" NOT NULL,
    "transactionId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderId" TEXT NOT NULL,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "userprofiles_userId_key" ON "userprofiles"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "settings_userId_key" ON "settings"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "restaurants_email_key" ON "restaurants"("email");

-- CreateIndex
CREATE UNIQUE INDEX "restaurantprofiles_restaurantId_key" ON "restaurantprofiles"("restaurantId");

-- CreateIndex
CREATE UNIQUE INDEX "restaurantaddresses_restaurantId_key" ON "restaurantaddresses"("restaurantId");

-- CreateIndex
CREATE UNIQUE INDEX "workinghours_restaurantId_dayOfWeek_key" ON "workinghours"("restaurantId", "dayOfWeek");

-- CreateIndex
CREATE UNIQUE INDEX "menucategories_restaurantId_name_key" ON "menucategories"("restaurantId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "menuitems_categoryId_name_key" ON "menuitems"("categoryId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "orders_orderNumber_key" ON "orders"("orderNumber");

-- CreateIndex
CREATE UNIQUE INDEX "orderitems_orderId_menuItemId_key" ON "orderitems"("orderId", "menuItemId");

-- CreateIndex
CREATE UNIQUE INDEX "deliveries_orderId_key" ON "deliveries"("orderId");

-- CreateIndex
CREATE UNIQUE INDEX "payments_orderId_key" ON "payments"("orderId");

-- AddForeignKey
ALTER TABLE "userprofiles" ADD CONSTRAINT "userprofiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "settings" ADD CONSTRAINT "settings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurantprofiles" ADD CONSTRAINT "restaurantprofiles_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "restaurants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurantaddresses" ADD CONSTRAINT "restaurantaddresses_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "restaurants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workinghours" ADD CONSTRAINT "workinghours_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "restaurants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menucategories" ADD CONSTRAINT "menucategories_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "restaurants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menuitems" ADD CONSTRAINT "menuitems_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "menucategories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "restaurants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orderitems" ADD CONSTRAINT "orderitems_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orderitems" ADD CONSTRAINT "orderitems_menuItemId_fkey" FOREIGN KEY ("menuItemId") REFERENCES "menuitems"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deliveries" ADD CONSTRAINT "deliveries_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deliveries" ADD CONSTRAINT "deliveries_driverId_fkey" FOREIGN KEY ("driverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;
