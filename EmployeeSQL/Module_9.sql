
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

---------------------------------------------------------------------
-- Data Analysis

-- List the employee number, last name, first name, sex, and salary of each employee.
-- employees(employee number, last name, first name, sex) + salaries(salary)
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986
-- employees(last name, last name, hire date) WHERE employees hired in 1986
SELECT last_name, first_name, hire_date
FROM employees e
WHERE hire_date BETWEEN '1986/01/01' AND '1986/12/30';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
-- departments(department number, department name) + employees(employee number, last name, and first name)

SELECT d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name
FROM employees e
INNER JOIN dept_manager dm
ON e.emp_no = dm.emp_no
INNER JOIN departments d
ON dm.dept_no = d.dept_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
-- departments(department number,department name) THROUGH dept_emp + employees (employee number, last name, first name)

SELECT d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
-- employees(first name, last name, and sex) WHERE first name Hercules, last name begins with B

SELECT e.first_name,e.last_name,e.sex
FROM employees e
WHERE e.first_name = 'Hercules' AND e.last_name like 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
-- department(Sales department) + employees(employee number, last name, and first name)
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- departments(department name) WHERE Sales and Development department + employees (employee number, last name, first name)
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,COUNT(*) AS "Number of employees with the same name"
FROM employees 
GROUP BY last_name
ORDER BY "Number of employees with the same name" DESC;
