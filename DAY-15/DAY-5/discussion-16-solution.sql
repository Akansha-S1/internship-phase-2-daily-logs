-- 1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name".
SELECT first_name AS "First Name", last_name AS "Last Name" FROM employees;

-- 2. Write a query to get unique department ID from employee table.
SELECT DISTINCT department_id FROM employees;

-- 3. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary).
SELECT first_name, last_name, salary, salary * 0.15 AS PF FROM employees;

-- 4. Write a query to get the maximum and minimum salary from employees table.
SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary FROM employees;

-- 5. Write a query to get the average salary and number of employees in the employees table.
SELECT AVG(salary) AS avg_salary, COUNT(*) AS num_employees FROM employees;

-- 6. Write a query get all first name from employees table in upper case.
SELECT UPPER(first_name) AS first_name_upper FROM employees;

-- 7. Write a query to get the first 3 characters of first name from employees table.
SELECT SUBSTRING(first_name, 1, 3) AS first_name_first3 FROM employees;

-- 8. Write a query to select first 10 records from a table.
SELECT * from employees limit 10;

-- 9. Write a query to get monthly salary (round 2 decimal places) of each and every employee.
SELECT first_name, last_name, round(salary/12,2) as 'Monthly Salary' FROM employees;

-- 10. Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order.
SELECT first_name, last_name, department_id from employees where department_id IN(30,100);
