--Task 1.1 Wildcard Searches for Product Names
SELECT productName FROM Product WHERE productName LIKE 'Classic%Car';

--Task 1.2 Flexible Search for Customer Addresses
select customer_address from customers where customer_address like '%Street%' or customer_address like '%Avenue%';

--Task 2.1 Orders within a Price Range
select order_id, SUM(order_amount) as total_amount from orders group by order_id having SUM(order_amount) between 100 and 500;

--Task 2.2 Payments within a Date Range
select * from payments where payment_date between '2024-01-01' and '2024-12-31';

--Task 3.1 Orders Exceeding Average Sale Amount
select order_id, SUM(order_amount) as total_amount from orders group by order_id having SUM(order_amount) > (select avg(order_amount) from orders);

--Task 3.2 Products with Maximum Order Quantity
select product_id from order_items group by product_id having COUNT(order_id) = (select MAX(order_count) from (select COUNT(order_id) as order_count from order_items group by product_id) as max_orders);

--Task 4.1 High-Value Customers in Specific Regions
select customer_id, customer_name, customer_region from customers where customer_id in (select customer_id from  payments where payment_amount > (select PERCENTILE_CONT(0.9) within group (order by payment_amount) from payments)) and (customer_region like 'North%' or customer_region like 'South%');

--Task 4.2 Seasonal Sales Analysis
select product_id, SUM(order_quantity) as total_quantity from order_items where order_date between '2024-01-01' and '2024-03-31' group by product_id
having sum(order_quantity) > (select avg(order_quantity) from order_items where order_date between '2024-01-01' and '2024-12-31');