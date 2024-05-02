-- 1. Employees Table
CREATE TABLE employees (
  employeeNumber int NOT NULL AUTO_INCREMENT,
  lastName varchar(50) NOT NULL,
  firstName varchar(50) NOT NULL,
  extension varchar(50) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  officeCode char(10) NOT NULL,
  reportsTo int DEFAULT NULL,
  jobTitle varchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber)
);
-- 2. Customers Table
CREATE TABLE customers (
  customerNumber int NOT NULL AUTO_INCREMENT,
  customerName varchar(50) NOT NULL,
  contactLastName varchar(50) NOT NULL,
  contactFirstName varchar(50) NOT NULL,
  phone varchar(50) DEFAULT NULL,
  addressLine1 varchar(50) DEFAULT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  city varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL,
  salesRepEmployeeNumber int DEFAULT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber)
);

-- 3. Orders Table
CREATE TABLE orders (
  orderNumber int NOT NULL AUTO_INCREMENT,
  customerNumber int NOT NULL,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments text DEFAULT NULL,
  PRIMARY KEY (orderNumber)
);

-- 4. Offices Table
CREATE TABLE offices (
  officeCode char(10) NOT NULL,
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(100) NOT NULL,
  addressLine2 varchar(100) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  PRIMARY KEY (officeCode)
);

-- 5. Product Lines Table
CREATE TABLE productlines (
  productLine varchar(50) NOT NULL,
  textDescription text,
  htmlDescription text,
  PRIMARY KEY (productLine)
);

-- 6. Products Table
CREATE TABLE products (
  productCode varchar(50) NOT NULL,
  productName varchar(50) NOT NULL,
  productLine varchar(50) NOT NULL,
  productScale varchar(10) DEFAULT NULL,
  productVendor varchar(50) DEFAULT NULL,
  productDescription text,
  quantityInStock smallint NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode)
);

-- 7. Order Details Table
CREATE TABLE orderdetails (
  orderNumber int NOT NULL,
  productCode varchar(50) NOT NULL,
  quantityOrdered int NOT NULL,
  priceEach decimal(10,2) NOT NULL,
  orderLineNumber smallint NOT NULL,
  PRIMARY KEY (orderNumber, orderLineNumber)
);

-- 8. Payments Table
CREATE TABLE payments (
  customerNumber int NOT NULL,
  checkNumber varchar(50) NOT NULL,
  paymentDate date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customerNumber, checkNumber)
);

-- Addinng foreign key constraints using ALTER TABLE commands:

ALTER TABLE employees
ADD CONSTRAINT fk_officeCode
FOREIGN KEY (officeCode) REFERENCES offices (officeCode);

ALTER TABLE employees
ADD CONSTRAINT fk_reportsTo
FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber);

ALTER TABLE orderdetails
ADD CONSTRAINT fk_orderNumber
FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber);

ALTER TABLE orderdetails
ADD CONSTRAINT fk_productCode
FOREIGN KEY (productCode) REFERENCES products (productCode);

ALTER TABLE orders
ADD CONSTRAINT fk_customerNumber
FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);

ALTER TABLE payments
ADD CONSTRAINT fk_customerNumber
FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);

ALTER TABLE products
ADD CONSTRAINT fk_productLine
FOREIGN KEY (productLine) REFERENCES productlines (productLine);