-- 1. Write a query to list the number of jobs available in the employees table.
SELECT COUNT(DISTINCT job_id) AS num_jobs FROM hr.employees;

-- 2. Write a query to get the total salaries payable to employees.
 SELECT SUM(salary) AS total_salaries_payable FROM hr.employees;

-- 3. Write a query to get the minimum salary from the employees table.
SELECT MIN(salary) AS min_salary FROM hr.employees;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
SELECT MAX(e.salary) AS max_programmer_salary FROM hr.employees e JOIN hr.jobs j ON e.job_id = j.job_id WHERE j.job_title = 'Programmer';

-- 5. Write a query to get the average salary and number ofSALARY employees working in department 90.
SELECT MIN(e.salary) AS min_programmer_salary FROM hr.employees e JOIN hr.jobs j ON e.job_id = j.job_id WHERE j.job_title = 'Programmer';

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees
SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary, SUM(salary) AS total_salary, AVG(salary) AS avg_salary FROM hr.employees;

-- 7. Write a query to get the number of employees with the same job.
SELECT job_id, COUNT(*) AS num_employees FROM hr.employees GROUP BY job_id;

-- 8. Write a query to get the difference between the highest and lowest salaries.
SELECT manager_id, MIN(salary) AS lowest_salary FROM hr.employees GROUP BY manager_id;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
SELECT manager_id, MIN(salary) AS lowest_salary FROM hr.employees GROUP BY manager_id;

-- 10. Write a query to get the department ID and the total salary payable in each department.
SELECT department_id, SUM(salary) AS total_salary_payable FROM hr.employees GROUP BY department_id;

-- 11. Write a query to get the average salary for each job ID excluding programmer.
SELECT e.job_id, AVG(e.salary) AS avg_salary FROM hr.employees e JOIN hr.jobs j ON e.job_id = j.job_id WHERE j.job_title != 'Programmer' GROUP BY e.job_id;

-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
SELECT job_id, SUM(salary) AS total_salary, MAX(salary) AS max_salary, MIN(salary) AS min_salary, AVG(salary) AS avg_salary FROM hr.employees WHERE department_id = 90 GROUP BY job_id;

-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
SELECT job_id, MAX(salary) AS max_salary FROM hr.employees WHERE salary >= 4000 GROUP BY job_id;

-- 14. Write a query to get the average salary for all departments employing more than 10 employees.
SELECT department_id, AVG(salary) AS avg_salary FROM hr.employees GROUP BY department_id HAVING COUNT(*) > 10;