-- Part 1: Understanding GROUP BY and Aggregate Functions

-- 1.1 Task: Generate a report showing the total sales per product line. Include the product line, the total number of products sold, and the total sales amount.
select 
    productline,
    count(productcode) as total_products_sold,
    sum(quantityordered * priceeach) as total_sales_amount
from 
    products
group by 
    productline;

-- 1.2 Task: Determine the total sales for each office, including office city, number of orders processed, and total sales amount.
select 
    o.city as office_city,
    count(distinct o.ordernumber) as number_of_orders,
    sum(od.quantityordered * od.priceeach) as total_sales_amount
from 
    offices o
join 
    employees e on o.officecode = e.officecode
join 
    customers c on e.employeenumber = c.salesrepemployeenumber
join 
    orders o on c.customernumber = o.customernumber
join 
    orderdetails od on o.ordernumber = od.ordernumber
group by 
    o.officecode;

-- Part 2: Filtering with HAVING Clause

-- 2.1 Task: Identify offices with an average order value greater than a certain threshold. Include office city, average order value, and total number of orders.
select 
    o.city as office_city,
    avg(od.quantityordered * od.priceeach) as average_order_value,
    count(distinct o.ordernumber) as total_orders
from 
    offices o
join 
    employees e on o.officecode = e.officecode
join 
    customers c on e.employeenumber = c.salesrepemployeenumber
join 
    orders o on c.customernumber = o.customernumber
join 
    orderdetails od on o.ordernumber = od.ordernumber
group by 
    o.officecode
having 
    avg(od.quantityordered * od.priceeach) > 5000; -- Specify your threshold value here

-- 2.2 Task: Filter product lines that have an average product sale price above a specific value.
select 
    productline,
    avg(priceeach) as average_product_price
from 
    products
group by 
    productline
having 
    avg(priceeach) > 100; -- Specify your threshold value here

-- Part 3: Complex Aggregations and Grouping

-- 3.1 Task: For each continent, find the average population and total GDP. Filter out continents with an average population below a certain threshold.
select 
    continent,
    avg(population) as average_population,
    sum(gnp) as total_gdp
from 
    country
group by 
    continent
having 
    avg(population) > 50000000; -- Specify your threshold value here

-- 3.2 Task: Identify countries with more than a specific number of official languages and display the country name, number of official languages, and total population.
select 
    name as country_name,
    count(language) as number_of_languages,
    sum(population) as total_population
from 
    country
join 
    countrylanguage using(code)
group by 
    code
having 
    count(language) > 3; -- Specify your threshold value here

-- Part 4: Advanced Scenario - Time Series Analysis

-- 4.1 Task: Calculate the month-over-month sales growth percentage for each product line.
select 
    productline,
    year(orderdate) as orderyear,
    month(orderdate) as ordermonth,
    (sum(quantityordered * priceeach) - lag(sum(quantityordered * priceeach)) over (partition by productline order by orderdate)) / lag(sum(quantityordered * priceeach)) over (partition by productline order by orderdate) as monthlysalesgrowth
from 
    orderdetails
join 
    products using (productcode)
join 
    orders using (ordernumber)
group by 
    productline, year(orderdate), month(orderdate);


-- 4.2 Task: Identify quarters with significantly higher sales for each office and investigate possible reasons.
select 
    offices.city as officecity,
    year(orderdate) as orderyear,
    quarter(orderdate) as orderquarter,
    sum(quantityordered * priceeach) as totalquarterlysales
from 
    offices
join 
    employees on offices.officecode = employees.officecode
join 
    customers on employees.employeenumber = customers.salesrepemployeenumber
join 
    orders on customers.customernumber = orders.customernumber
join 
    orderdetails on orders.ordernumber = orderdetails.ordernumber
group by 
    offices.officecode, year(orderdate), quarter(orderdate)
order by 
    offices.officecode, orderyear, orderquarter;