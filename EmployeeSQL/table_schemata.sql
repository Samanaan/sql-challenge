--Drop code just in case a table needs to be reset.
DROP TABLE salaries;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE titles;
DROP TABLE departments;
DROP TABLE employees;
---------------------------------------------------------------------

-- initialize tables (6 tables)
CREATE TABLE departments (
  	dept_no VARCHAR(4),
  	dept_name VARCHAR(30),
	PRIMARY KEY (dept_no)
);

CREATE TABLE titles (
  	title_ID VARCHAR(5),
  	emp_no VARCHAR(30),
	PRIMARY KEY (title_ID)
);

CREATE TABLE employees (
  	emp_no INT,
  	emp_title_id VARCHAR(5) NOT NULL,
  	birth_date DATE,
	first_name VARCHAR(20) NOT NULL,
  	last_name VARCHAR(20) NOT NULL,
  	sex VARCHAR(1),
	hire_date DATE,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(emp_title_id) REFERENCES titles(title_ID)
);

CREATE TABLE salaries (
  	emp_no INT,
  	salary INT(10),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
  	emp_no INT,
  	dept_no VARCHAR,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
  	dept_no VARCHAR,
  	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
---------------------------------------------------------------------
-- Pull data form CSV files (This is for back up but I used the method of right click on table -> import data)

COPY employees
FROM '/Users/shivani/Desktop/Data_Bootcamp/SQL_Challenge_6/sql-challenge/data/employees.csv'
CSV HEADER
DELIMITER ','

COPY salaries
FROM 'Users/shivani/Desktop/Data_Bootcamp/SQL_Challenge_6/sql-challenge/data/salaries.csv'
CSV HEADER
DELIMITER ','

COPY dept_emp
FROM '/Users/shivani/Desktop/Data_Bootcamp/SQL_Challenge_6/sql-challenge/data/dept_emp.csv'
CSV HEADER
DELIMITER ','

COPY dept_manager
FROM '/Users/shivani/Desktop/Data_Bootcamp/SQL_Challenge_6/sql-challenge/data/dept_manager.csv'
CSV HEADER
DELIMITER ','

COPY titles
FROM '/Users/shivani/Desktop/Data_Bootcamp/SQL_Challenge_6/sql-challenge/data/titles.csv'
CSV HEADER
DELIMITER ','

COPY departments
FROM '/Users/shivani/Desktop/Data_Bootcamp/SQL_Challenge_6/sql-challenge/data/departments.csv'
CSV HEADER
DELIMITER ','