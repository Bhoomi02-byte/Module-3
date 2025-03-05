 -- ========================================
-- Step 1: Creating the Employees Table
-- ========================================
CREATE TABLE employees (
    id INT PRIMARY KEY, 
    name VARCHAR(250) NOT NULL,
    age INT, 
    salary DECIMAL(12,2),
    dept VARCHAR

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

-- Finds all employees whose names **end with** 'bhoomi'
SELECT * FROM employees WHERE employee_name LIKE '%bhoomi';

-- Finds all employees whose names **start with** 'bhoomi'
SELECT * FROM employees WHERE employee_name LIKE 'bhoomi%';


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




--Question on (where clauses) select.

Q1: Write an SQL query to create a table named student with columns:
StudentID (integer)
name (varchar, 250 characters, not null)

 Insert the following data into the student table:
StudentID	Name
201	Jocky
202	Rocky
203	Ram
204	Rama
205	Esha
206	Bhoomi
207	Joker
208	Diksha
210	Naveen

Create another table called Marks with the following columns:
ID (Primary Key)
StudentID 
subject (varchar, 50 characters)
marks (integer)

Insert the following data into the Marks table:
ID	StudentID	Subject	Marks
1	201	English	80
2	202	Hindi	60
3	203	English	85
4	204	Hindi	90
5	205	English	80
6	207	Sanskrit	80
7	208	Hindi	80
8	206	English	80
9	205	Sanskrit	80

SQL UPDATE Query
Write an SQL query to update the Marks table and set the subject column to NULL where the StudentID is 208.

Query Conditions (WHERE and JOIN)
 Write an SQL query to find the names of students who have not taken English or who have no records in the Marks table.
 Write an SQL query to find the names of students who have taken subjects other than English.
 Write an SQL query to find students whose subject is NULL in the Marks table.
 Write an SQL query to find students who scored more than 80 marks.
 Write an SQL query to find students who have taken either 'Hindi' or 'Sanskrit' as subjects.

Pattern Matching (LIKE)
 Write an SQL query to find students whose names start with 'R'.
 Write an SQL query to find students whose names end with 'a'.
 Write an SQL query to find students whose names contain 'oo'.



-- Creating the 'student' table with columns 'StudentID' (unique student identifier) and 'name' (student's name, cannot be NULL)
Create table student(
  StudentID int,
  name varchar(250) not null
);

-- Inserting sample data into the 'student' table
insert into student 
values
(201,'Jocky'),
(202,'Rocky'),
(203,'Ram'),
(204,'Rama'),
(205,'Esha'),
(206,'Bhoomi'),
(207,'Joker'),
(208,'Diksha'),
(210,'Naveen');

-- Creating the 'Marks' table with a primary key 'ID', 'StudentID' (foreign key reference to 'student' table), 'subject', and 'marks' columns
Create table Marks(
  ID int primary key,
  StudentID int,
  subject varchar(50),
  marks int
);

-- Inserting sample data into the 'Marks' table
insert into Marks 
values
(1,201,'English',80),
(2,202,'Hindi',60),
(3,203,'English',85),
(4,204,'Hindi',90),
(5,205,'English',80),
(6,207,'Sanskrit',80),
(7,208,'Hindi',80),
(8,206,'English',80),
(9,205,'Sanskrit',80);

-- Updating the 'Marks' table: Setting 'subject' to NULL for the student with StudentID 208
update Marks
set [subject]=null
where StudentID=208;

-- Selecting students who have not taken English OR have no records in the 'Marks' table
select s.name
       from student s left join Marks m
on s.StudentID = m.StudentID
where m.subject!='English'or m.ID is null;

-- Selecting students who have taken subjects other than English
select s.name
from student s  join Marks m
on s.StudentID = m.StudentID
where m.subject!='English';

-- Selecting students whose subjects are NULL in the 'Marks' table
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.subject is null;

-- Selecting students who scored more than 80 marks
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.marks > 80;

-- Selecting students who have taken either 'Hindi' or 'Sanskrit' as subjects
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.subject in ('Hindi', 'Sanskrit');

-- Selecting students whose names start with 'R'
select s.name
from student s 
where s.name like 'R%';

-- Selecting students whose names end with 'a'
select s.name
from student s 
where s.name like '%a';

-- Selecting students whose names contain 'oo'
select s.name
from student s 
where s.name like '%oo%';

-- Selecting students who scored between 60 and 85 marks
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.marks between 60 and 85;

-- Selecting all records from the 'student' table
SELECT *FROM student;

-- Selecting all records from the 'Marks' table
SELECT *FROM Marks;
