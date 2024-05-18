-- 1.Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
select concat(FIRST_NAME," ",LAST_NAME) as emp_name, SALARY from employees where SALARY > ( select SALARY from employees where last_name='BULL');

-- 2.Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
select concat(FIRST_NAME," ",LAST_NAME) as emp_name from employees where DEPARTMENT_ID=(select DEPARTMENT_ID from departments where DEPARTMENT_NAME="IT");

-- 3.Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA-based department.
select concat (FIRST_NAME,' ',LAST_NAME) as emp_name from employees where MANAGER_ID in (select EMPLOYEE_ID from employees where DEPARTMENT_ID in (select DEPARTMENT_ID from departments where LOCATION_ID in (select LOCATION_ID from locations where COUNTRY_ID='US')));

-- 4.Write a query to find the name (first_name, last_name) of the employees who are managers.
select concat (FIRST_NAME,' ',LAST_NAME) as emp_name from employees where EMPLOYEE_ID in (select MANAGER_ID from employees);

-- 5.Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
select concat (FIRST_NAME,' ',LAST_NAME) as emp_name, SALARY from employees where SALARY>  (select avg(SALARY) from employees);

-- 6.Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their jobs.
select concat (FIRST_NAME,' ',LAST_NAME) as emp_name, SALARY from employees e where SALARY = (select min(SALARY) from jobs j where e.JOB_ID=j.JOB_ID);
    
-- 7.Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments.
select concat (FIRST_NAME,' ',LAST_NAME) as emp_name, SALARY from employees where SALARY>  (select avg(SALARY) from employees) and DEPARTMENT_ID in (select DEPARTMENT_ID from departments where DEPARTMENT_NAME like 'IT%');

-- 8.Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earnings of Mr. Bell.
select concat (FIRST_NAME, " ",LAST_NAME) as emp_name, SALARY from employees where SALARY> (select salary from employees where LAST_NAME='BELL');

-- 9.Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
select concat(first_name," ",last_name) as employee_name, salary from employees e where salary= all(select min(salary) from employees e1 where e1.department_id = e.department_id);

-- 10.Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
select concat(first_name," ",last_name) as employee_name, salary from employees e where salary> all(select avg(salary) from employees e1 where e1.department_id = e.department_id);

-- 11.Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary from the lowest to highest.
select concat (FIRST_NAME," ",LAST_NAME) as emp_name, SALARY from employees where SALARY > all(select SALARY from employees where JOB_ID = 'SH_CLERK') order by SALARY;

-- 12.Write a query to find the name (first_name, last_name) of the employees who are not managers.
select concat (FIRST_NAME," ",LAST_NAME) as emp_name from employees where EMPLOYEE_ID not in(select MANAGER_ID from employees);

-- 13.Write a query to display the employee ID, first name, last name, and department names of all employees.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, (select department_name from departments where e.DEPARTMENT_ID=DEPARTMENT_ID) as department_name from employees e;

-- 14.Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY,DEPARTMENT_ID from employees e where SALARY > (select avg(SALARY) from employees e1 where e.DEPARTMENT_ID = e1.DEPARTMENT_ID group by DEPARTMENT_ID);

-- 15.Write a query to fetch even numbered records from employees table.
select * from employees where EMPLOYEE_ID%2=0;

-- 16.Write a query to find the 5th maximum salary in the employees table.
select SALARY from employees order by SALARY desc limit 1 offset 4;

-- 17.Write a query to find the 4th minimum salary in the employees table.
select SALARY from employees order by SALARY limit 1 offset 3;

-- 18.Write a query to select the last 10 records from a table.
select * from employees order by EMPLOYEE_ID desc limit 10;

-- 19.Write a query to list the department ID and name of all the departments where no employee is working.
select DEPARTMENT_ID, DEPARTMENT_NAME from departments where DEPARTMENT_ID not in (select DEPARTMENT_ID from employees);

-- 20.Write a query to get 3 maximum salaries.
select SALARY from employees order by SALARY desc limit 3;

-- 21.Write a query to get 3 minimum salaries.
select SALARY from employees order by SALARY limit 3;

-- 22.Write a query to get nth max salaries of employees.
    -- n value should be specified by the user
select distinct salary from employees order by salary desc limit 1 offset n-1;