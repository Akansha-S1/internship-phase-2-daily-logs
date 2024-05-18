-- Part 1: Understanding GROUP BY and Aggregate Functions

-- 1.1 Task: Generate a report showing the total sales per product line. Include the product line, the total number of products sold, and the total sales amount.
SELECT p.productLine,
       SUM(od.quantityOrdered) AS total_products_sold,
       SUM(od.quantityOrdered * od.priceEach) AS total_sales_amount
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productLine;

-- 1.2 Task: Determine the total sales for each office, including office city, number of orders processed, and total sales amount.
SELECT o.city AS office_city,
       COUNT(o.officeCode) AS num_orders_processed,
       SUM(od.quantityOrdered * od.priceEach) AS total_sales_amount
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders ord ON c.customerNumber = ord.customerNumber
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY o.city;

-- Part 2: Filtering with HAVING Clause

-- Task: High value order analysis
select o.city as officeCity, avg(od.quantityOrdered*od.priceEach) as average_order_value,count(od.orderNumber) as no_of_orders from offices o join employees e using(officeCode) join customers c on e.employeeNumber=c.salesRepEmployeeNumber join orders ods using(customerNumber) join orderdetails od using(orderNumber) group by o.city having avg(od.quantityOrdered*od.priceEach)>2000;

-- 2.1 Task: Identify offices with an average order value greater than a certain threshold. Include office city, average order value, and total number of orders.
select productLine,avg(quantityOrdered*priceEach) as avg_sale_amount from orderdetails join products using(productCode) group by productLine having avg(quantityOrdered*priceEach)<3000;

-- 2.2 Task: Filter product lines that have an average product sale price above a specific value.
SELECT 
    productLine AS productline,
    AVG(buyPrice) AS average_product_price
FROM 
    Products
GROUP BY 
    productLine
HAVING 
    AVG(buyPrice) > 100;


-- Part 3: Complex Aggregations and Grouping

-- 3.1 Task: Continent Analysis: For each continent, find the average population and total GDP. Filter out continents with an average population below a certain threshold.
SELECT 
    continent,
    AVG(population) AS average_population,
    SUM(gnp) AS total_gdp
FROM 
    world.country
GROUP BY 
    continent
HAVING 
    AVG(population) > 50000000;

-- 3.2 Task: Language Diversity: Identify countries with more than a specific number of official languages and display the country name, number of official languages, and total population.
SELECT 
    c.name AS country_name,
    COUNT(cl.language) AS number_of_languages,
    SUM(c.population) AS total_population
FROM 
    world.country c
JOIN 
    world.countrylanguage cl ON c.code = cl.countrycode
GROUP BY 
    c.code, c.name
HAVING 
    COUNT(cl.language) > 3;

-- Part 4: Advanced Scenario - Time Series Analysis
-- Task 4.1: Monthly Sales Growth: Calculate the month-over-month sales growth percentage for each product line.
WITH MonthlySales AS (
    SELECT
        YEAR(orderDate) AS year,
        MONTH(orderDate) AS month,
        productLine,
        SUM(quantityOrdered * priceEach) AS monthly_sales,
        LAG(SUM(quantityOrdered * priceEach)) OVER (PARTITION BY productLine ORDER BY YEAR(orderDate), MONTH(orderDate)) AS previous_month_sales
    FROM
        Orders
    JOIN
        OrderDetails ON Orders.orderNumber = OrderDetails.orderNumber
    JOIN
        Products ON OrderDetails.productCode = Products.productCode
    GROUP BY
        YEAR(orderDate), MONTH(orderDate), productLine
)
SELECT
    year,
    month,
    productLine,
    monthly_sales,
    previous_month_sales,
    CASE
        WHEN previous_month_sales IS NULL THEN NULL
        ELSE ((monthly_sales - previous_month_sales) / previous_month_sales) * 100
    END AS sales_growth_percentage
FROM
    MonthlySales;

-- TASK 4.2: Seasonal Effect Analysis: Identify quarters with significantly higher sales for each office and investigate possible reasons.
SELECT 
    offices.city AS officecity,
    YEAR(orderdate) AS orderyear,
    QUARTER(orderdate) AS orderquarter,
    SUM(quantityordered * priceeach) AS totalquarterlysales
FROM 
    offices
JOIN 
    employees ON offices.officecode = employees.officecode
JOIN 
    customers ON employees.employeenumber = customers.salesrepemployeenumber
JOIN 
    orders ON customers.customernumber = orders.customernumber
JOIN 
    orderdetails ON orders.ordernumber = orderdetails.ordernumber
GROUP BY 
    offices.officecode, YEAR(orderdate), QUARTER(orderdate)
ORDER BY 
    offices.officecode, orderyear, orderquarter;

-- 4.1.1 Task: Calculate the month-over-month sales growth percentage for each product line.
SELECT 
    productline,
    YEAR(orderdate) AS orderyear,
    MONTH(orderdate) AS ordermonth,
    (SUM(quantityordered * priceeach) - LAG(SUM(quantityordered * priceeach)) OVER (PARTITION BY productline ORDER BY YEAR(orderdate), MONTH(orderdate))) / LAG(SUM(quantityordered * priceeach)) OVER (PARTITION BY productline ORDER BY YEAR(orderdate), MONTH(orderdate)) AS monthlysalesgrowth
FROM 
    orderdetails
JOIN 
    products USING (productcode)
JOIN 
    orders USING (ordernumber)
GROUP BY 
    productline, YEAR(orderdate), MONTH(orderdate);



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