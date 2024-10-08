DROP DATABASE IF EXISTS Ecommerce_DB;
CREATE DATABASE Ecommerce_DB;
USE Ecommerce_DB;

-- CUSTOMER table
CREATE TABLE CUSTOMER (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNo VARCHAR(15) NOT NULL,
    HashedPassword VARCHAR(60) NOT NULL,
    EmailAddress VARCHAR(250) NOT NULL UNIQUE,
    MemberStatus ENUM('REGULAR', 'SILVER', 'GOLD', 'PLATINUM') NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ADDRESS table
CREATE TABLE ADDRESS (
    AddressId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CustomerId INT NOT NULL,
    Address1 VARCHAR(250) NOT NULL,
    Address2 VARCHAR(250),
    City VARCHAR(250) NOT NULL,
    State VARCHAR(250),
    Country VARCHAR(250) NOT NULL,
    Zipcode VARCHAR(250) NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(id)
);

-- CREDIT_LINE table
CREATE TABLE CREDIT_LINE (
    CustomerId INT NOT NULL,
    CustomerName VARCHAR(101) NOT NULL, 
    PRIMARY KEY (CustomerId),
    FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(id)
);


-- PRODUCT table
CREATE TABLE PRODUCT (
    ProductId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    ProductDescription VARCHAR(500) NOT NULL,
    ProductType ENUM('Desktop', 'Laptop', 'Printer', 'Accessory') NOT NULL,
    Price DOUBLE NOT NULL
);

-- ORDERS table
CREATE TABLE ORDERS (
    OrderId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CustomerId INT NOT NULL,
    ProductId INT NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES PRODUCT(ProductId),
    FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(id),
    DateOrdered TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- PAYMENT table
CREATE TABLE PAYMENT (
    PaymentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CustomerId INT NOT NULL,
    OrderId INT NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES CUSTOMER(id),
    FOREIGN KEY (OrderId) REFERENCES ORDERS(OrderId),
    Amount DOUBLE NOT NULL
);

-- PAYMENT_METHOD table
CREATE TABLE PAYMENT_METHOD (
    PaymentMethodId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    PaymentId INT NOT NULL,
    FOREIGN KEY (PaymentId) REFERENCES PAYMENT(PaymentId),
    CardType VARCHAR(60) NOT NULL,
    CardOwner VARCHAR(255) NOT NULL,
    ExpYear INT NOT NULL,
    ExpMonth INT NOT NULL,
    CONSTRAINT CheckExpMonth CHECK (ExpMonth BETWEEN 1 AND 12),
    CONSTRAINT CheckExpYear CHECK (ExpYear >= YEAR(CURDATE())),
    CardNo VARCHAR(20) NOT NULL,
    SecurityNo INT NOT NULL,
    BillingAddress VARCHAR(500) NOT NULL
);

-- SHIPMENT table
CREATE TABLE SHIPMENT (
    ShipmentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    OrderId INT NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES ORDERS(OrderId),
    CustomerName VARCHAR(255) NOT NULL,
    ShipmentAddress VARCHAR(500) NOT NULL,
    OrderStatus VARCHAR(60) NOT NULL,
    OrderLocation VARCHAR(255) NOT NULL,
    OrderShipped TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	OrderDelivered TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
