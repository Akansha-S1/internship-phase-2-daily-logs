-- 1. UPDATABLE VIEW:
-- Create an updatable view that includes customernumber, customername, contactlastname, and contactfirstname from the customers table. 
create view customer_view as
select customernumber, customername, contactlastname, contactfirstname
from customers;
-- Then, try to update the contactfirstname for a specific customernumber.
update customer_view 
set contactfirstname = 'newfirstname'
where customernumber = 103;

-- 2. READ ONLY VIEW:
-- Create a read-only view that joins the orderdetails table and the products table on productcode and includes ordernumber, productname, and quantityordered.
create view order_product_view as
select od.ordernumber, p.productname, od.quantityordered
from orderdetails od 
join products p on od.productcode = p.productcode;
-- Trying to update this view will result in an error because it involves multiple base tables.
update order_product_view 
set quantityordered = 50
where ordernumber = 10100;

-- 3. INCLINE VIEW:
-- Write a query that uses an inline view to get the total number of orders for each customer.
-- The inline view should select customernumber and ordernumber from the orders table.
-- The main query should then group by customernumber.
select iv.customernumber, count(iv.ordernumber) as total_orders
from (
  select customernumber, ordernumber 
  from orders
) as iv
group by iv.customernumber;

-- 4. MATERIALIZED VIEW:
-- Stored procedure to create or refresh the materialized view table.
create procedure refresh_materialized_view()
begin
  drop table if exists materialized_view;
  create table materialized_view as
  select p.productname, sum(od.quantityordered) as totalquantityordered
  from orderdetails od 
  join products p on od.productcode = p.productcode
  group by p.productname;
end;
-- Trigger to refresh the materialized view after each insert on orderdetails.
create trigger orderdetails_after_insert
after insert on orderdetails
for each row
begin
  call refresh_materialized_view();
end;