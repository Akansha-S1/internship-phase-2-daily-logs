-- Task 1.1: Wildcard Searches for Product Names
-- Objective: Create a query to find product names that start with "Classic", include any characters in the middle, and end with "Car".
select productName from products where productName like 'Classic%Car';

-- Task 1.2: Flexible Search for Customer Addresses
-- Objective: Identify all customer addresses that contain the word "Street" or "Avenue" in any part of the address field.
select customerName, address from customers where address like '%Street%' or address like '%Avenue%';

-- Task 2.1: Orders within a Price Range
-- Objective: Find all orders with total amounts between two values, indicating mid-range transactions.
select orderNumber, sum(quantityOrdered * priceEach) as totalAmount from orderDetails group by orderNumber having totalAmount between 1000 and 2000;

-- Task 2.2: Payments within a Date Range
-- Objective: Retrieve all payments made within a specific date range, focusing on a high-activity period.
select * from payments where paymentDate between '2003-01-01' and '2003-06-30';

-- Task 3.1: Orders Exceeding Average Sale Amount
-- Objective: Identify orders where the total amount exceeds the average sale amount across all orders.
select orderNumber, sum(quantityOrdered * priceEach) as totalAmount from orderDetails group by orderNumber having totalAmount > (select avg(quantityOrdered * priceEach) from orderDetails);

-- Task 3.2: Products with Maximum Order Quantity
-- Objective: Find products that have been ordered in quantities equal to the maximum quantity ordered for any product.
select productName from products where quantityInStock = (select max(quantityInStock) from products);

-- Task 4.1: High-Value Customers in Specific Regions
-- Objective: Identify customers who have made payments in the top 10% of all payments and are located in specific geographic regions.
select customerName, country, amount from customers join payments using (customerNumber) where amount > (select 0.9 * max(amount) from payments) and country like 'USA%';

-- Task 4.2: Seasonal Sales Analysis
-- Objective: Analyze sales data to identify products with significantly higher sales in specific seasons compared to their annual sales average.
select productName, sum(quantityOrdered) as totalQuantity, avg(quantityOrdered) as annualAverage from orderDetails join orders using (orderNumber) join products using (productCode) where orderDate between '2003-01-01' and '2003-12-31' group by productName having totalQuantity > 2 * annualAverage;