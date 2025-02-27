-- ========================================
-- Step 1: Creating the Employees Table
-- ========================================
CREATE TABLE employees (
    id INT PRIMARY KEY, 
    name VARCHAR(250) NOT NULL,
    age INT, 
    salary DECIMAL(12,2),
    dept VARCHAR
);

-- ========================================
-- Step 2: Altering Table (Adding Columns)
-- ========================================
ALTER TABLE employees ADD marks INT NOT NULL;
ALTER TABLE employees ADD email VARCHAR(100);
ALTER TABLE employees ADD age INT NOT NULL;

-- Renaming columns using sp_rename
EXEC sp_rename 'employees.email', 'contact_email', 'COLUMN';
EXEC sp_rename 'employees.name', 'employee_name', 'COLUMN';

-- Modifying column type
ALTER TABLE employees ALTER COLUMN salary DECIMAL(12,2);
ALTER TABLE employees ALTER COLUMN employee_name VARCHAR(200);
ALTER TABLE employees ALTER COLUMN dept VARCHAR NOT NULL;

-- ========================================
-- Step 3: Inserting Data into Employees Table
-- ========================================
INSERT INTO employees(id, employee_name, age, salary, dept) 
VALUES 
    (8, 'bhoomi', 22, 20000, 'A', 10),
    (21, 'bhoomi', 22, 40000, 'A', 10);

INSERT INTO employees(id, employee_name, age, salary, dept,marks) 
VALUES 
    (2, 'bhoomii', 23, 200000, 'B',80),
    (22, 'bhoomii', 23, 600000, 'B',78),
    (3, 'bhoomiii', 24, 208000, 'C',56),
    (4, 'bhomi', 25, 200007, 'D',45),
    (5, 'bhumi', 26, 80000, 'E',43),
    (10, 'bhomi', 28, 8000, 'F',32),
    (20, 'bhomi', 28, 8000, 'F',100),
    (29, 'Esha', 28, 8000, 'K',39);

-- ========================================
-- Step 4: Updating Values in the Existing Table
-- ========================================
UPDATE employees 
SET marks = 10 
WHERE id = 8;

UPDATE employees 
SET contact_email = 'bhoomi@.com'
WHERE id = 20;

-- ========================================
-- Step 5: Selection Queries
-- ========================================

-- Retrieve all employees
SELECT id, employee_name, age, salary, contact_email, dept FROM employees;

-- Retrieve distinct employee names
SELECT DISTINCT employee_name FROM employees;

-- Retrieve marks column only
SELECT employee_name, marks FROM employees;

-- Retrieve employee names along with their salaries
SELECT employee_name, salary FROM employees;

-- Retrieve employees ordered by salary (Highest to Lowest)
SELECT * FROM employees ORDER BY salary DESC;

-- Retrieve employees whose name starts with 'bhoomi'
SELECT * FROM employees WHERE employee_name LIKE '%bhoomi%';

-- Retrieve employees working in department 'A' or 'B' using BETWEEN
SELECT * FROM employees WHERE dept BETWEEN 'A' AND 'B';

Select * from employees where dept in ('A' , 'B');

-- Retrieve employees with salary greater than 50,000
SELECT * FROM employees WHERE salary > 50000;

-- ========================================
-- Step 6: Aggregate Functions
-- ========================================

-- Count total number of employees
SELECT COUNT(*) AS total_employees FROM employees;

-- Find the minimum salary
SELECT MIN(salary) AS min_salary FROM employees;

-- Find the maximum salary
SELECT MAX(salary) AS max_salary FROM employees;

-- Find the total sum of employee salaries
SELECT SUM(salary) AS total_salary FROM employees;

-- Find the average age of employees
SELECT AVG(age) AS avg_age FROM employees;

-- Find the average salary per department
SELECT dept, AVG(salary) AS avg_salary FROM employees GROUP BY dept;

-- ========================================
-- Step 7: Grouping and Having Clause
-- ========================================

-- Count employees in each department 
SELECT dept, COUNT(*) AS employee_count 
FROM employees 
GROUP BY dept 
HAVING COUNT(*) > 1;

-- ========================================
-- Step 8: Creating the Departments Table
-- ========================================
CREATE TABLE departments (
    dept VARCHAR PRIMARY KEY,
    dept_head VARCHAR(250)
);

-- Inserting data into departments table
INSERT INTO departments VALUES 
('A', 'Mr. X'),
('B', 'Ms. Y'),
('C', 'Mr. Z');

-- ========================================
-- Step 9: Joins (INNER, LEFT, RIGHT, FULL, CROSS, SELF)
-- ========================================
SELECT *FROM employees
SELECT *FROM departments
-- Inner Join: Fetch employees along with their department heads
SELECT e.id, e.dept, e.employee_name, e.salary, d.dept_head
FROM employees e
INNER JOIN departments d ON e.dept = d.dept;

-- Left Join: Fetch all employees and their department heads (including employees without departments)
SELECT e.id, e.employee_name, e.salary, e.dept,  d.dept_head
FROM employees e
LEFT JOIN departments d ON e.dept = d.dept;

-- Right Join: Fetch all departments and their employees (including departments without employees)
SELECT e.id, e.employee_name, e.salary, e.dept, e.marks, d.dept_head
FROM employees e
RIGHT JOIN departments d ON e.dept = d.dept;

-- Full Outer Join: Fetch all employees and departments, including unmatched records from both tables
SELECT e.id, e.employee_name, e.salary, e.dept, e.marks, d.dept_head
FROM employees e
FULL OUTER JOIN departments d ON e.dept = d.dept;

-- Cross Join: Creates all possible combinations between employees and departments
SELECT e.employee_name, d.dept_head
FROM employees e
CROSS JOIN departments d;

-- Self Join: Find employees working in the same department
SELECT e1.employee_name AS Employee1, e2.employee_name AS Employee2, e1.dept
FROM employees e1
JOIN employees e2 ON e1.dept = e2.dept AND e1.id <> e2.id;


-- Drop the departments table (if needed)
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;


