--STORED PROCEDURE

-- =============================================
-- 1️⃣ Stored Procedure: SelectAllEmployee
-- Description: Retrieves all employee records.
-- =============================================
CREATE PROCEDURE SelectAllEmployee
AS
BEGIN
    SELECT * FROM employees;
END;
GO

-- Execute the procedure
EXEC SelectAllEmployee;

------------------------------------------------------

-- =============================================
-- 2️⃣ Stored Procedure: GetEmployeeById
-- Description: Retrieves an employee's details by ID.
-- =============================================
CREATE PROCEDURE GetEmployeeById
    @id INT
AS
BEGIN
    SELECT * FROM employees WHERE ID = @id;
END;


-- Execute with example ID
EXEC GetEmployeeById @id = 20;

------------------------------------------------------

-- =============================================
-- 3️⃣ Stored Procedure: GetTotalEmployees
-- Description: Returns the total number of employees.
-- =============================================
CREATE PROCEDURE GetTotalEmployees
    @total INT OUTPUT
AS
BEGIN
    SELECT @total = COUNT(*) FROM employees;
END;
GO

-- Declare a variable to store the result
DECLARE @count as INT;
EXEC GetTotalEmployees @count OUTPUT;
PRINT 'Total Employees:'+ CAST(@count AS VARCHAR);

------------------------------------------------------

-- =============================================
-- 4️⃣ Stored Procedure: CheckSalary
-- Description: Checks if an employee's salary is high or low.
-- =============================================
CREATE PROCEDURE CheckSalary
    @emp_id INT,
    @status VARCHAR(20) OUTPUT
AS
BEGIN
    DECLARE @emp_salary INT;
    
    -- Fetch the salary of the employee
    SELECT @emp_salary = salary FROM employees WHERE ID = @emp_id;
    
    -- Determine salary status
    IF @emp_salary > 50000
        SET @status = 'High Salary';
    ELSE
        SET @status = 'Low Salary';
END;
GO

-- Declare a variable to store the salary status
DECLARE @status_ VARCHAR(200);
EXEC CheckSalary @emp_id=20, @status= @status_ OUTPUT;
PRINT 'Salary Status: ' + @status_;

------------------------------------------------------

-- =============================================
-- 5️⃣ Stored Procedure: PrintNumbers
-- Description: Prints numbers from 1 to 5.
-- =============================================
CREATE PROCEDURE PrintNumbers
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= 5
    BEGIN
        PRINT @i;
        SET @i = @i + 1;
    END;
END;
GO

-- Execute the procedure
EXEC PrintNumbers;

------------------------------------------------------

-- =============================================
-- 6️⃣ Stored Procedure: UpdateSalary
-- Description: Updates an employee's salary and handles errors.
-- =============================================
CREATE PROCEDURE UpdateSalary
    @emp_id INT,
    @new_salary INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Attempt to update salary
        UPDATE employees SET salary = @new_salary WHERE ID = @emp_id;
        
        -- Check if any row was updated
        IF @@ROWCOUNT = 0  
            THROW 50001, 'Employee ID not found', 1;

        -- Commit transaction if successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Store the error message
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Error: ' + @ErrorMessage;
        
        -- Rollback transaction on failure
        ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

-- Execute with a non-existing employee ID
EXEC UpdateSalary @new_salary=700000, @emp_id=99;

------------------------------------------------------

-- =============================================
-- 7️⃣ Stored Procedure: DeleteEmployee
-- Description: Deletes an employee by ID.
-- =============================================
CREATE PROCEDURE DeleteEmployee
    @emp_id INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM employees WHERE ID = @emp_id;
        
        -- Check if any row was deleted
        IF @@ROWCOUNT = 0  
            THROW 50002, 'Employee ID not found', 1;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Error: ' + @ErrorMessage;
        ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

-- Execute delete procedure
EXEC DeleteEmployee @emp_id = 10;

------------------------------------------------------

-- =============================================
-- 8️⃣ Stored Procedure: AddEmployee
-- Description: Inserts a new employee record.
-- =============================================
CREATE PROCEDURE AddEmployee
    @id INT,
    @name_emp VARCHAR(50),
    @salary INT
AS
BEGIN
    INSERT INTO employees (ID, [employee_name], salary) 
    VALUES (@id, @name_emp, @salary);
END;


-- Execute procedure to add a new employee
EXEC AddEmployee @id = 55, @name_emp = 'John Doe', @salary = 60000;

------------------------------------------------------

-- =============================================
-- 9️⃣ Stored Procedure: GetHighSalaryEmployees
-- Description: Retrieves employees with a salary above 50,000.
-- =============================================
CREATE PROCEDURE GetHighSalaryEmployees
AS
BEGIN
    SELECT * FROM employees WHERE salary > 50000;
END;
GO

-- Execute the procedure
EXEC GetHighSalaryEmployees;

------------------------------------------------------

-- =============================================
-- 🔟 Stored Procedure: IncreaseSalaryByPercentage
-- Description: Increases an employee's salary by a given percentage.
-- =============================================
CREATE PROCEDURE IncreaseSalaryByPercentage
    @emp_id INT,
    @percentage FLOAT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE employees 
        SET salary = salary + (salary * (@percentage / 100)) 
        WHERE ID = @emp_id;

        -- Check if any row was updated
        IF @@ROWCOUNT = 0  
            THROW 50003, 'Employee ID not found', 1;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Error: ' + @ErrorMessage;
        ROLLBACK TRANSACTION;
    END CATCH;
END;
GO

-- Execute to increase salary by 10%
EXEC IncreaseSalaryByPercentage @emp_id = 1, @percentage = 10;



-- SQL INTERMEDIATE CHALLENGE 1

CREATE TABLE HACKERS(
HACKER_ID INT,
NAME VARCHAR(250)
);

CREATE TABLE CHALLENGES(
CHALLENGE_ID INT,
HACKER_ID INT
);

INSERT INTO HACKERS(HACKER_ID, NAME)
VALUES (5077, 'Rose'),
       (21283, 'Angela'),
       (62743, 'Frank'),
       (88255, 'Patrick'),
       (96196, 'Lisa');

INSERT INTO CHALLENGES(CHALLENGE_ID, HACKER_ID)
VALUES (61654, 5077),
       (58302, 21283),
       (40587, 88255),
       (29477, 5077),
       (1220, 21283),
       (69514, 21283),
       (46561, 62743),
       (58077, 62743),
       (18483, 88255),
       (76766, 21283),
       (52382, 5077),
       (74467, 21283),
       (33625, 96196),
       (26053, 88255),
       (42665, 62743),
       (12859, 62743),
       (70094, 21283),
       (34599, 88255),
       (54680, 88255),
       (61881, 5077);

-- QUERY TO COUNT TOTAL CHALLENGES PER HACKER
SELECT H.HACKER_ID, H.NAME, COUNT(*) AS TOTAL_CHALLENGES
FROM HACKERS H 
JOIN CHALLENGES C ON H.HACKER_ID = C.HACKER_ID
GROUP BY H.HACKER_ID, H.NAME
ORDER BY TOTAL_CHALLENGES DESC, H.HACKER_ID;

-- QUERY TO GET HACKERS WITH MAX OR UNIQUE CHALLENGE COUNTS
SELECT H.HACKER_ID, H.NAME, COUNT(*) AS TOTAL_CHALLENGES
FROM HACKERS H
JOIN CHALLENGES C ON H.HACKER_ID = C.HACKER_ID
GROUP BY H.HACKER_ID, H.NAME
HAVING COUNT(*) = (SELECT MAX(CHALLENGE_COUNT) 
                   FROM (SELECT HACKER_ID, COUNT(*) AS CHALLENGE_COUNT 
                         FROM CHALLENGES 
                         GROUP BY HACKER_ID) AS MAX_COUNT)
   OR COUNT(*) IN (SELECT CHALLENGE_COUNT 
                   FROM (SELECT COUNT(*) AS CHALLENGE_COUNT 
                         FROM CHALLENGES 
                         GROUP BY HACKER_ID) AS COUNTS
                   GROUP BY CHALLENGE_COUNT 
                   HAVING COUNT(CHALLENGE_COUNT) = 1)
ORDER BY TOTAL_CHALLENGES DESC, HACKER_ID;

-- SQL INTERMEDIATE CHALLENGE 2

CREATE TABLE SYMMETRIC(
X INT,
Y INT
);

INSERT INTO SYMMETRIC 
VALUES (20, 20),
       (20, 20),
       (20, 21),
       (23, 22),
       (22, 23),
       (21, 20);

-- QUERY TO FIND SYMMETRIC PAIRS
SELECT DISTINCT A.X, A.Y
FROM SYMMETRIC A
JOIN SYMMETRIC B
ON A.X = B.Y AND A.Y = B.X
WHERE A.X <= A.Y
ORDER BY A.X, A.Y;

-- SQL INTERMEDIATE CHALLENGE 3

CREATE TABLE STUDENTS(
ID INT,
NAME VARCHAR(250)
);

CREATE TABLE FRIENDS(
ID INT,
FRIEND_ID INT
);

CREATE TABLE PACKAGES(
ID INT,
SALARY FLOAT
);

INSERT INTO STUDENTS(ID, NAME)
VALUES (1, 'Ashely'),
       (2, 'Samantha'),
       (3, 'Julia'),
       (4, 'Scarlet');

INSERT INTO FRIENDS(ID, FRIEND_ID)
VALUES (1, 2),
       (2, 3),
       (3, 4),
       (4, 1);

INSERT INTO PACKAGES(ID, SALARY)
VALUES (1, 15.20),
       (2, 10.06),
       (3, 11.55),
       (4, 12.12);

-- QUERY TO FIND STUDENTS WHOSE FRIENDS HAVE HIGHER SALARY
SELECT S.NAME
FROM STUDENTS S 
JOIN FRIENDS F ON S.ID = F.ID
JOIN PACKAGES P1 ON S.ID = P1.ID
JOIN PACKAGES P2 ON F.FRIEND_ID = P2.ID
WHERE P2.SALARY > P1.SALARY
ORDER BY P2.SALARY;
