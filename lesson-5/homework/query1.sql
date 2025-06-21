DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');
-- ================================
--Q1
SELECT * ,
ROW_NUMBER () OVER (ORDER BY Salary) as UniqueRank

FROM Employees

---===============================
--Q2
;WITH Ranked AS (
    SELECT *, 
    DENSE_RANK() OVER (ORDER BY Salary) AS SalaryRank
    FROM Employees
)
SELECT * 
FROM Ranked
WHERE SalaryRank in (
    SELECT SalaryRank
    FROM Ranked
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)

--==================================
--Q3
;WITH RankedSalaries AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)

SELECT *
FROM RankedSalaries
WHERE SalaryRank <= 2;
--===================================
--Q4
;WITH RankedSalaries AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY SALARY ASC) AS SalaryRank
        FROM Employees
)

SELECT * 
FROM RankedSalaries
WHERE SalaryRank = 1;
--====================================
--Q5

SELECT *, SUM(Salary) OVER (PARTITION BY DEPARTMENT ORDER BY HireDate) as RunningTotal
FROM Employees;
--===================================
--Q6
SELECT *, SUM(Salary) OVER (PARTITION BY DEPARTMENT) as Total
FROM Employees;
--==================================
--Q7
SELECT *, Ceiling(AVG(Salary) OVER (PARTITION BY DEPARTMENT)) as AvgSalary
FROM Employees;
--==================================
--Q8
;WITH AveragedSalary AS (
    SELECT *, CEILING(AVG(Salary) OVER (PARTITION BY Department)) AS AvgSalary
    FROM Employees
)

SELECT *,
       ABS(Salary - AvgSalary) AS Difference
FROM AveragedSalary
--===================================
--Q9
SELECT *, 
   CEILING(
        AVG(Salary) OVER (
            ORDER BY EmployeeID 
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        )
   ) AS MovingSalary
FROM Employees;

--===============================================
---Q10
SELECT SUM(Salary) AS TotalSalaryOfLast3Hires
FROM (
    SELECT TOP 3 Salary
    FROM Employees
    ORDER BY HireDate DESC
) AS Last3;
--===============================================
--Q11
SELECT *,
       ROUND(
           AVG(Salary) OVER (
               ORDER BY HireDate
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ), 2
       ) AS RunningAvgSalary
FROM Employees;
--==============================================
--Q12
SELECT *,
       MAX(Salary) OVER (
           ORDER BY EmployeeID
           ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
       ) AS MaxSlidingSalary
FROM Employees;
--===============================================
--Q13
SELECT *, 
    CAST(
        ROUND(Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department), 2)
        AS DECIMAL(10,2)
    ) AS Percentage
FROM Employees;
