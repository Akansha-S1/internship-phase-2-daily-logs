-- 1.Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
    select d.department_name,l.location_id,l.street_address,l.city,l.state_province,c.country_name from locations l inner join countries c on c.country_id=l.country_id inner join departments d on d.location_id=l.location_id group by d.department_id;

-- 2.Write a query to find the name (first_name, last name), department ID, and department name of all the employees.
    select concat(e.first_name," ",e.last_name) as employee_name,e.department_id,d.department_name from employees e inner join departments d on d.department_id=e.department_id group by e.employee_id;

-- 3.Write a query to find the name (first_name, last_name), job, department ID, and name of the employees who work in London.
    select concat(e.first_name," ",e.last_name) as employee_name,j.job_title,d.department_id from employees e inner join jobs j using(job_id) inner join departments d using (department_id) inner join locations l using(location_id) where l.city='London';

-- 4.Write a query to find the employee id, name (last_name) along with their manager_id, and name (last_name).
    select e.employee_id,e.last_name,e.manager_id,e1.last_name from employees e inner join employees e1 on e.manager_id=e1.employee_id;

-- 5.Write a query to find the name (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
    select concat(e.first_name," ",e.last_name) as employee_name,e.hire_date from employees e inner join employees e1 on e1.last_name='Jones' where e.hire_date>e1.hire_date;

-- 6.Write a query to get the department name and number of employees in the department.
    select d.department_name,count(e.employee_id) as number_of_employees from departments d inner join employees e on e.department_id=d.department_id group by department_name;

-- 7.Write a query to find the employee ID, job title, number of days between the ending date and the starting date for all jobs in department 90.
    select employee_id,job_title,end_date-start_date as number_of_days from job_history natural join jobs where department_id=90;

-- 8.Write a query to display the department ID and name and first name of the manager.
    select d.department_id,d.department_name,e.first_name as manager_name from departments d inner join employees e on d.manager_id=e.manager_id;

-- 9.Write a query to display the department name, manager name, and city.
    select d.department_name,concat(e.first_name," ",e.last_name) as manager_name,l.city from departments d inner join employees e on d.manager_id=e.employee_id inner join locations l using(location_id);

-- 10.Write a query to display the job title and average salary of employees.
    select job_title,round(avg(salary),2) as average_salary from employees inner join jobs using(job_id) group by job_title;

-- 11.Write a query to display job title, employee name, and the difference between the salary of the employee and minimum salary for the job.
    select job_title,concat(first_name," ",last_name) as employee_name,(salary-min_salary) as difference_of_salary from employees inner join jobs using(job_id);

-- 12.Write a query to display the job history of any employee who is currently drawing more than 10000 of salary.
    select jh.* from job_history jh inner join employees e on jh.employee_id=e.employee_id where e.salary>10000;

-- 13.Write a query to display department name, name (first_name, last_name), hire date, the salary of the manager for all managers whose experience is more than 15 years.
    select d.department_name,concat(e.first_name, " ",e.last_name) as employee_name,e.hire_date,e.salary from employees e inner join departments d using(department_id) inner join job_history jh using(employee_id) where e.employee_id=d.manager_id and end_date-start_date>15;