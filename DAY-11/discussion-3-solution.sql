-- Query 1: List customers who locate in the same city by joining the customers table to itself
select 
    c1.city,
    c1.customerName,
    c2.customerName
from 
    customers c1
inner join 
    customers c2 using(city)
where 
    c1.customerName > c2.customerName
order by 
    c1.city;

-- Query 2: Get productCode, productName, and textDescription of product lines
select 
    p.productCode,
    p.productName,
    pl.textDescription
from 
    products p
natural join 
    productLines pl;

-- Query 3: Get orderNumber, order status, and total sales from orders and orderdetails
select 
    orderNumber,
    status,
    sum(quantityOrdered * priceEach) as total
from 
    orders
inner join 
    orderdetails using(orderNumber)
group by 
    orderNumber;

-- Query 4: Fetch complete order details and sort by orderNumber, orderLineNumber
select 
    orderNumber,
    orderDate,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
from 
    orders
inner join 
    orderdetails using(orderNumber)
inner join 
    products using(productCode)
order by 
    orderNumber, orderLineNumber;

-- Query 5: Fetch detailed order information including customer name and sort by orderNumber, orderLineNumber
select 
    orderNumber,
    orderDate,
    customerName,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
from 
    customers
inner join 
    orders using(customerNumber)
inner join 
    orderdetails using(orderNumber)
inner join 
    products using(productCode)
order by 
    orderNumber, orderLineNumber;

-- Query 6: Find the sales price of product S10_1678 that is less than MSRP
select 
    orderNumber,
    productName,
    msrp,
    priceEach
from 
    products
inner join 
    orderdetails using(productCode)
where 
    productCode = 'S10_1678'
    and msrp > priceEach;

-- Query 7: Find all customers and their orders using LEFT JOIN
select 
    c.customerNumber,
    c.customerName,
    o.orderNumber,
    o.status
from 
    customers c
left join 
    orders o using(customerNumber);

-- Query 8: Find customers who have no orders using LEFT JOIN and filter for NULL orderNumber
select 
    c.customerNumber,
    c.customerName,
    o.orderNumber,
    o.status
from 
    customers c
left join 
    orders o using(customerNumber)
where 
    o.orderNumber is NULL;