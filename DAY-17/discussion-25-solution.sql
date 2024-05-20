-- Scenario 1: Advanced Analytics Dashboard
    -- Create a view to calculate the daily total sales
create view daily_sales as
select date(orderDate) as order_date, sum(quantityOrdered * priceEach) as total_sales
from orders join orderdetails using (orderNumber)
group by order_date;

    -- Create an updatable view to show the number of orders for each day and include order status
create view daily_orders as
select date(orderDate) as order_date, count(orderNumber) as num_orders, status
from orders
group by order_date, status;

    -- Create a view to identify the most purchased product of each day
create view daily_top_product as
select date(orderDate) as order_date, productCode, sum(quantityOrdered) as total_quantity
from orders join orderdetails using (orderNumber)
group by order_date, productCode
order by total_quantity desc;

    -- Create a combined view for the daily report
create view daily_report as
select ds.order_date, ds.total_sales, do.num_orders, dtp.productCode as top_product, dtp.total_quantity
from daily_sales ds
join daily_orders do on ds.order_date = do.order_date
join (
  select dtp1.order_date, dtp1.productCode, dtp1.total_quantity
  from daily_top_product dtp1
  join (
    select order_date, max(total_quantity) as max_quantity
    from daily_top_product
    group by order_date
  ) dtp2 on dtp1.order_date = dtp2.order_date and dtp1.total_quantity = dtp2.max_quantity
) dtp on ds.order_date = dtp.order_date;

-- Scenario 2: Sales Monitoring System
    -- Create a view to show the total number of customers handled by each sales rep
create view rep_customers as
select employeeNumber, count(distinct customerNumber) as num_customers
from customers
group by employeeNumber;

    -- Create a view to display the total payments received by each sales rep
create view rep_payments as
select employeeNumber, sum(amount) as total_payments
from customers join payments using (customerNumber)
group by employeeNumber;

    -- Create a view to show the total number of orders handled by each sales rep
create view rep_orders as
select employeeNumber, count(distinct orderNumber) as num_orders
from customers join orders using (customerNumber)
group by employeeNumber;

    -- Create a combined view to display the performance of each sales rep
create view rep_performance as
select rc.employeeNumber, rc.num_customers, rp.total_payments, ro.num_orders
from rep_customers rc
join rep_payments rp on rc.employeeNumber = rp.employeeNumber
join rep_orders ro on rc.employeeNumber = ro.employeeNumber;

-- Scenario 3: HR and Sales Data Analysis
-- Assuming this part of the SQL is run in the hr database
    -- Create a view in the hr database to show the department and age of each employee
create view emp_details as
select employee_id, department_id, timestampdiff(year, birth_date, curdate()) as age
from employees;

-- Assuming this part of the SQL is run in the classicmodels database
    -- Create a view in the classicmodels database to show the sales performance of each employee
create view emp_sales_performance as
select employeeNumber, sum(amount) as total_sales
from customers join payments using (customerNumber)
group by employeeNumber;