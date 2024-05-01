CREATE TABLE productlines(
-> productLine varchar(50) NOT NULL,
-> textDescription varchar(1000) DEFAULT NULL,
-> htmlDescription longtext,
-> image blob,
-> CONSTRAINT PK_productlines PRIMARY KEY (productLine)
-> )ENGINE=InnoDB;

CREATE TABLE products(
-> productCode varchar(10) NOT NULL,
-> productName varchar(20) NOT NULL,
-> productLine varchar(50) NOT NULL,
-> productScale varchar(8) NOT NULL,
-> productVendor varchar(20) NOT NULL,
-> productDescription longtext NOT NULL,
-> quantityInStock smallint(5) NOT NULL,
-> buyPrice decimal(8,2) NOT NULL,
-> MSRP decimal(8,2) NOT NULL,
-> CONSTRAINT PK_products PRIMARY KEY (productCode),
-> CONSTRAINT FK_productlines_products FOREIGN KEY (productLine) REFERENCES productlines (productLine)
-> )ENGINE=InnoDB;

CREATE TABLE offices(
-> officeCode varchar(5) NOT NULL,
-> city varchar(20) NOT NULL,
-> phone char(10) NOT NULL,
-> addressLine1 varchar(100) NOT NULL,
-> addressLine2 varchar(100) DEFAULT NULL,
-> state varchar(20) NOT NULL,
-> country varchar(50) NOT NULL,
-> postalCode varchar(10) NOT NULL,
-> territory varchar(20) NOT NULL,
-> CONSTRAINT PK_offices PRIMARY KEY (officeCode)
-> )ENGINE=InnoDB;

CREATE TABLE employees(
-> employeeNumber int(10) NOT NULL,
-> lastName varchar(30) DEFAULT NULL,
-> firstName varchar(30) NOT NULL,
-> extension varchar(15) NOT NULL,
-> email varchar(100) NOT NULL,
-> officeCode varchar(5) NOT NULL,
-> reportsTo int(10) DEFAULT NULL,
-> jobTitle varchar(20) NOT NULL,
-> CONSTRAINT PK_employees PRIMARY KEY (employeeNumber),
-> CONSTRAINT FK_employees_employees FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber),
-> CONSTRAINT FK_offices_employees FOREIGN KEY (officeCode) REFERENCES offices (officeCode)
-> )ENGINE=InnoDB;

CREATE TABLE customers(
-> customerNumber int(11) NOT NULL,
-> customerName varchar(50) NOT NULL,
-> contactLastName varchar(50) NOT NULL,
-> contactFirstName varchar(50) NOT NULL,
-> phone char(10) NOT NULL,
-> addressLine1 varchar(100) NOT NULL,
-> addressLine2 varchar(100) DEFAULT NULL,
-> city varchar(20) NOT NULL,
-> state varchar(20) NOT NULL,
-> postalCode varchar(10) NOT NULL,
-> country varchar(50) NOT NULL,
-> salesRepEmployeeNumber int(10) DEFAULT NULL,
-> CONSTRAINT PK_customers PRIMARY KEY (customerNumber),
-> CONSTRAINT FK_employees_customers FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber)
-> )ENGINE=InnoDB;

CREATE TABLE payments(
-> customerNumber int(11) NOT NULL,
-> checkNumber varchar(20) NOT NULL,
-> paymentDate date NOT NULL,
-> amount decimal(8,2) NOT NULL,
-> CONSTRAINT PK_payments PRIMARY KEY (customerNumber,checkNumber),
-> CONSTRAINT FK_customers_payments FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
-> )ENGINE=InnoDB;

CREATE TABLE orders(
-> orderNumber int(11) NOT NULL UNIQUE,
-> orderDate date NOT NULL,
-> requiredDate date NOT NULL,
-> shippedDate date DEFAULT NULL,
-> status varchar(10) NOT NULL,
-> comments mediumtext,
-> customerNumber int(11) NOT NULL,
-> CONSTRAINT PK_orders PRIMARY KEY (orderNumber),
-> CONSTRAINT FK_customers_orders FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
-> )ENGINE=InnoDB;

CREATE TABLE orderdetails(
-> orderNumber int(11) NOT NULL,
-> productCode varchar(10) NOT NULL,
-> quantityOrdered int(11) NOT NULL,
-> priceEach decimal(10,2) NOT NULL,
-> orderLineNumber mediumint(6) NOT NULL,
-> CONSTRAINT PK_orderdetails PRIMARY KEY (orderNumber,productCode),
-> CONSTRAINT FK_products_orderdetails FOREIGN KEY (productCode) REFERENCES products (productCode)
-> )ENGINE=InnoDB;