-- Query 1: Find the addresses of all departments
select 
    d.location_id,
    l.street_address,
    l.city,
    l.state_province,
    c.country_name
from 
    departments d
join 
    locations l on d.location_id = l.location_id
join 
    countries c on l.country_id = c.country_id;

-- Query 2: Find the name, department ID, and department name of all employees
select 
    concat(e.first_name, ' ', e.last_name) as name,
    e.department_id,
    d.department_name
from 
    employees e
join 
    departments d on e.department_id = d.department_id;

-- Query 3: Find the name, job, department ID of employees who work in London
select 
    concat(e.first_name, ' ', e.last_name) as name,
    j.job_title,
    e.department_id
from 
    employees e
join 
    jobs j on e.job_id = j.job_id
join 
    departments d on e.department_id = d.department_id
join 
    locations l on d.location_id = l.location_id
where 
    l.city = 'London';

-- Query 4: Find employee ID, name, manager ID, and manager name
select 
    e1.employee_id,
    e1.last_name,
    e1.manager_id,
    e2.last_name as manager_name
from 
    employees e1
join 
    employees e2 on e1.manager_id = e2.employee_id;

-- Query 5: Find employees hired after 'Jones'
select 
    concat(first_name, ' ', last_name) as name,
    hire_date
from 
    employees
where 
    hire_date > (select hire_date from employees where last_name = 'Jones');

-- Query 6: Get department name and number of employees in each department
select 
    d.department_name,
    count(*) as no_of_employees
from 
    employees e
join 
    departments d on e.department_id = d.department_id
group by 
    d.department_name;

-- Query 7: Get job ID, name, and number of days between start and end date for jobs in department 90
select 
    j.job_id,
    j.job_title,
    datediff(jh.end_date, jh.start_date) as days_between
from 
    job_history jh
join 
    jobs j on jh.job_id = j.job_id
where 
    j.department_id = 90;

-- Query 8: Display department ID, manager name, and manager's first name
select 
    d.department_id,
    concat(e1.first_name, ' ', e1.last_name) as manager_name,
    e2.first_name as manager_first_name
from 
    employees e1
join 
    employees e2 on e1.manager_id = e2.employee_id
join 
    departments d on e1.department_id = d.department_id;

-- Query 9: Display department name, manager name, and city
select 
    d.department_name,
    concat(e.first_name, ' ', e.last_name) as manager_name,
    l.city
from 
    employees e
join 
    departments d on e.department_id = d.department_id
join 
    locations l on d.location_id = l.location_id
where 
    e.employee_id = d.manager_id;

-- Query 10: Display job title and average salary of employees
select 
    j.job_title,
    avg(e.salary) as average_salary
from 
    employees e
join 
    jobs j on e.job_id = j.job_id
group by 
    j.job_title;

-- Query 11: Display job title, employee name, and salary difference from minimum salary for the job
select 
    j.job_title,
    concat(e.first_name, ' ', e.last_name) as employee_name,
    e.salary - j.min_salary as salary_difference
from 
    employees e
join 
    jobs j on e.job_id = j.job_id;

-- Query 12: Display job history of employees currently earning more than $10000
select 
    jh.*
from 
    job_history jh
join 
    employees e on jh.employee_id = e.employee_id
where 
    e.salary > 10000;

-- Query 13: Display department name, manager name, hire date, and salary of managers with more than 15 years of experience
select 
    d.department_name,
    concat(e.first_name, ' ', e.last_name) as manager_name,
    jh.hire_date,
    e.salary
from 
    employees e
join 
    departments d on e.department_id = d.department_id
join 
    job_history jh on e.employee_id = jh.employee_id
where 
    e.employee_id = d.manager_id
    and datediff(jh.end_date, jh.start_date) > 15;