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