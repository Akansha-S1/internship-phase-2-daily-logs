-- 1. Write a SQL statement to create a table countries including columns country_id, country_name, and region_id, and make sure that the combination of columns country_id and region_id will be unique.
CREATE TABLE countries (
country_id VARCHAR(10) PRIMARY KEY,
country_name VARCHAR(40),
region_id VARCHAR(10) NOT NULL,
UNIQUE (country_id, region_id)
);

-- 2. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
CREATE TABLE jobs (
job_id VARCHAR(10) PRIMARY KEY,
job_title VARCHAR(35) DEFAULT '',
min_salary DECIMAL(6, 0) DEFAULT 150000,
max_salary DECIMAL(6, 0)
);

-- 3. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id, and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which exist in the jobs table.
CREATE TABLE job_history (
employee_id INT,
start_date DATE,
end_date DATE,
job_id VARCHAR(15) NOT NULL,
department_id VARCHAR(15) NOT NULL,
CONSTRAINT pk_job_history PRIMARY KEY (employee_id, start_date),
CONSTRAINT fk_job_history FOREIGN KEY (job_id) REFERENCES jobs(job_id),
CONSTRAINT chk_dates CHECK (start_date < end_date)
);

-- 4. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id, and department_id and make sure that the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination values, which combinations exist in the departments table.
CREATE TABLE departments (
department_id VARCHAR(10) NOT NULL PRIMARY KEY,
department_name VARCHAR(30) NOT NULL,
manager_id int NOT NULL,
location_id VARCHAR(10)
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
phone_number VARCHAR(20),
hire_date DATE,
job_id VARCHAR(15),
salary DECIMAL(10, 2),
commission DECIMAL(10, 2),
manager_id INT,
department_id VARCHAR(10),
CONSTRAINT uk_email UNIQUE (email),
CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

ALTER TABLE departments
ADD CONSTRAINT fk_mgr_id FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

ALTER TABLE employees
ADD CONSTRAINT fk_manager_department FOREIGN KEY (manager_id, department_id) REFERENCES departments(manager_id, department_id);

-- 5. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column department_id, reference by the column department_id of departments table, can contain only those values which are exists in the departments table and another foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables.
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
email VARCHAR(100) NOT NULL UNIQUE,
phone_number VARCHAR(20),
hire_date DATE,
job_id VARCHAR(10) REFERENCES jobs(job_id),
salary DECIMAL(10, 2),
commission DECIMAL(10, 2),
manager_id INT,
department_id VARCHAR(10),
CONSTRAINT fk_manager_department FOREIGN KEY (manager_id, department_id) REFERENCES departments(manager_id, department_id)
) ENGINE=InnoDB;

-- 6. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE CASCADE that lets you allow to delete records in the employees(child) table that refer to a record in the jobs(parent) table when the record in the parent table is deleted and the ON UPDATE RESTRICT actions reject any updates.
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
job_id VARCHAR(10) REFERENCES jobs(job_id) ON DELETE CASCADE ON UPDATE RESTRICT,
salary DECIMAL(10, 2)
) ENGINE=InnoDB;

-- 7. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE SET NULL action will set the foreign key column values in the child table(employees) to NULL when the record in the parent table(jobs) is deleted, with a condition that the foreign key column in the child table must accept NULL values and the ON UPDATE SET NULL action resets the values in the rows in the child table(employees) to NULL values when the rows in the parent table(jobs) are updated.
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
job_id VARCHAR(10) REFERENCES jobs(job_id) ON DELETE SET NULL ON UPDATE SET NULL,
salary DECIMAL(10, 2)
) ENGINE=InnoDB;

-- 8. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE NO ACTION and the ON UPDATE NO ACTION actions will reject the deletion and any updates.
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
job_id VARCHAR(10) REFERENCES jobs(job_id)ON DELETE NO ACTION ON UPDATE NO ACTION,
salary DECIMAL(10, 2)
) ENGINE=InnoDB;