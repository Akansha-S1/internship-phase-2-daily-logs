-- 1.Write a query to display a list of customers who locate in the same city by joining the customers table to itself.
    select c.city,c.customerName,c1.customerName from customers c inner join customers c1 on c.city=c1.city where c.customerNumber<>c1.customerNumber order by c.city;

-- 2.Write a query to get:
    -- The productCode and productName from the products table.
    -- The textDescription of product lines from the productlines table.
    select p.productCode,p.productName,pl.textDescription from products p inner join productlines pl using (productLine);

-- 3.Write a query that returns order number, order status, and total sales from the orders and orderdetails tables as follows:
    select orderNumber,status,sum(quantityOrdered*priceEach) as total_sales from orders inner join orderdetails using (orderNumber) group by orderNumber;

-- 4.Write a query to fetch the complete details of orders from the orders, orderDetails, and products table, and sort them by orderNumber and orderLineNumber as follows:
    select o.orderNumber,o.orderDate,od.orderLineNumber,p.productName,od.quantityOrdered,od.priceEach from orders o inner join orderDetails od on o.orderNumber=od.orderNumber inner join products p on od.productCode=p.productCode order by orderNumber,orderLineNumber;

-- 5.Write a query to perform INNER JOIN of four tables:
    -- Display the details sorted by orderNumber, orderLineNumber as per the following
    select orderNumber,orderDate,customerName,orderLineNumber,productName,quantityOrdered,priceEach from orders inner join customers using (customerNumber) inner join orderdetails using(orderNumber) inner join products using(productCode) order by orderNumber,orderLineNumber; 

-- 6.Write a query to find the sales price of the product whose code is S10_1678 that is less than the manufacturer’s suggested retail price (MSRP) for that product as follows:
    select orderNumber,productName,msrp,priceEach from orderdetails inner join products using (productCode) where productCode='S10_1678' and priceEach<msrp;

-- 7.Each customer can have zero or more orders while each order must belong to one customer. Write a query to find all the customers and their orders as follows:
    select customerNumber, customerName, orderNumber,status from customers left join orders using (customerNumber) order by customerNumber;

-- 8.Write a query that uses the LEFT JOIN to find customers who have no order:
    select customerNumber,customerName,orderNumber,status from customers left join orders using(customerNumber) where orderNumber is NULL;