-- 1. Employees Table
REATE TABLE employees (
  employeeNumber INT NOT NULL PRIMARY KEY,
  lastName VARCHAR(255) NOT NULL,
  firstName VARCHAR(255) NOT NULL,
  extension VARCHAR(255),
  email VARCHAR(255),
  officeCode CHAR(10) NOT NULL,
  reportsTo INT,
  jobTitle VARCHAR(255) NOT NULL,
  FOREIGN KEY (officeCode) REFERENCES offices(officeCode)
);

-- 2. Customers Table
CREATE TABLE customers (
  customerNumber INT NOT NULL PRIMARY KEY,
  customerName VARCHAR(255) NOT NULL,
  contactLastName VARCHAR(255) NOT NULL,
  contactFirstName VARCHAR(255) NOT NULL,
  phone VARCHAR(255),
  addressLine1 VARCHAR(255),
  addressLine2 VARCHAR(255),
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  postalCode VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  salesRepEmployeeNumber INT,
  creditLimit DECIMAL(10,2),
  FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

-- 3. Orders Table
CREATE TABLE orders (
  orderNumber INT NOT NULL PRIMARY KEY,
  orderDate DATE NOT NULL,
  requiredDate DATE NOT NULL,
  shippedDate DATE,
  status VARCHAR(255) NOT NULL,
  comments VARCHAR(255),
  customerNumber INT NOT NULL,
  FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

-- 4. Offices Table
CREATE TABLE offices (
  officeCode CHAR(10) NOT NULL PRIMARY KEY,
  city VARCHAR(255) NOT NULL,
  phone VARCHAR(255),
  addressLine1 VARCHAR(255),
  addressLine2 VARCHAR(255),
  state VARCHAR(255) NOT NULL,
  postalCode VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  territory VARCHAR(255) NOT NULL
);

-- 5. Product Lines Table
CREATE TABLE productLines (
  productLine VARCHAR(255) NOT NULL PRIMARY KEY,
  textDescription VARCHAR(255),
  htmlDescription TEXT
);

-- 6. Products Table
CREATE TABLE products (
  productCode VARCHAR(255) NOT NULL PRIMARY KEY,
  productName VARCHAR(255) NOT NULL,
  productLine VARCHAR(255) NOT NULL,
  productScale VARCHAR(10),
  productVendor VARCHAR(255),
  productDescription TEXT,
  quantityInStock SMALLINT,
  buyPrice DECIMAL(10,2),
  MSRP DECIMAL(10,2),
  image BLOB,
  FOREIGN KEY (productLine) REFERENCES productLines(productLine)
);

-- 7. Order Details Table
CREATE TABLE orderDetails (
  orderNumber INT NOT NULL,
  productCode VARCHAR(255) NOT NULL,
  quantityOrdered SMALLINT NOT NULL,
  priceEach DECIMAL(10,2) NOT NULL,
  orderLineNumber SMALLINT NOT NULL,
  PRIMARY KEY (orderNumber, productCode),
  FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
  FOREIGN KEY (productCode) REFERENCES products(productCode)
);

-- 8. Payments Table
CREATE TABLE payments (
  customerNumber INT NOT NULL,
  checkNumber VARCHAR(255) NOT NULL,
  paymentDate DATE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (customerNumber, checkNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

