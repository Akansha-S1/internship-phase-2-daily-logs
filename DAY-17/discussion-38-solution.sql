-- 1. Simplifying complex queries
-- Suppose you have to repeatedly run a complex query that fetches detailed order information by joining orders, orderdetails, and products tables. This can be simplified using a view.
CREATE VIEW order_summary AS
SELECT o.orderNumber, o.orderDate, d.productCode, p.productName, d.quantityOrdered, d.priceEach
FROM orders o
JOIN orderdetails d ON o.orderNumber = d.orderNumber
JOIN products p ON d.productCode = p.productCode;

-- 2. Restricting access to data
-- If you want to provide access to order information but don't want to expose the price details, you can create a view that excludes price-related columns:
CREATE VIEW order_info AS
SELECT o.orderNumber, o.orderDate, d.productCode, p.productName, d.quantityOrdered
FROM orders o
JOIN orderdetails d ON o.orderNumber = d.orderNumber
JOIN products p ON d.productCode = p.productCode;

-- 3. Updatable View:
-- Create an updatable view based on the customers table:
CREATE OR REPLACE VIEW customer_view AS
SELECT customerNumber, customerName, phone, city, country
FROM customers;

-- To use this view to update the customers table:
UPDATE customer_view SET phone = '1234567890' WHERE customerNumber = 103;

-- 4. Read-Only View:
-- Create a read-only view based on the orders table:
CREATE OR REPLACE VIEW readonly_order_view AS
SELECT orderNumber, orderDate, status
FROM orders;

-- 5. Materialized View:
-- Create a  materialized view emulated based on products and orderdetails tables, which aggregates the total quantity ordered for each product:

-- 5.1 Create a table:
CREATE TABLE materialized_product_order_view AS
SELECT p.productCode, p.productName, SUM(od.quantityOrdered) as totalQuantity
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName;

-- 5.2 Create a procedure to update it:
CREATE PROCEDURE RefreshMaterializedProductOrderView()
BEGIN
    DELETE FROM materialized_product_order_view;

    INSERT INTO materialized_product_order_view
    SELECT p.productCode, p.productName, SUM(od.quantityOrdered) as totalQuantity
    FROM products p
    JOIN orderdetails od ON p.productCode = od.productCode
    GROUP BY p.productCode, p.productName;
END

-- 6. Inline Views:
-- Use an inline view to find products that have orders exceeding a certain quantity:
SELECT iv.productCode, iv.productName
FROM
(SELECT p.productCode, p.productName, SUM(od.quantityOrdered) as totalQuantity
 FROM products p
 JOIN orderdetails od ON p.productCode = od.productCode
 GROUP BY p.productCode, p.productName) AS iv
WHERE iv.totalQuantity > 1000;

-- Distinguish: If your subquery is in the FROM clause, it can be called an inline view:
    -- Subquery:
    -- A subquery in a WHERE clause might look like this:
    SELECT customerNumber, checkNumber, amount
    FROM payments
    WHERE amount > 
        (SELECT AVG(amount) 
        FROM payments);

    -- Inline View:
    SELECT iv.customerNumber, COUNT(iv.checkNumber) AS numPayments
FROM 
    (SELECT customerNumber, checkNumber 
    FROM payments) AS iv
GROUP BY iv.customerNumber;