drop table if exists Employees
drop table if exists Departments
drop table if exists projects
create table Employees (
	EmployeeID integer identity(1,1) primary key,
	Name varchar(30),
	DepartmentID integer,
	Salary integer
);
CREATE TABLE Departments (
	DepartmentID integer primary key,
	DepartmentName varchar(30)
);
create table projects (
	ProjectID integer identity(1,1) primary key,
	ProjectName varchar(30),
	EmployeeID integer
);
INSERT INTO Employees (Name, DepartmentID, Salary) VALUES
('Alice', 101, 60000),
('Bob', 102, 70000),
('Charlie', 101, 65000),
('David', 103, 72000),
('Eva', NULL, 68000);
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');
INSERT INTO Projects  (ProjectName, EmployeeID) VALUES
('Alpha', 1),
('Beta', 2),
('Gamma', 1),
('Delta', 4),
('Omega', NULL);

--select * from Employees
--select * from Departments
--select * from Projects


-- ================================ 
-- Q1
SELECT 
    Employees.EmployeeID,
    Employees.Name,
    Departments.DepartmentName,
    Employees.Salary
FROM 
    Employees
INNER JOIN 
    Departments 
ON 
    Employees.DepartmentID = Departments.DepartmentID;

-- ======================================================
-- Q2

SELECT * FROM Employees
LEFT JOIN Departments ON 
    Employees.DepartmentID = Departments.DepartmentID;


-- ==================================================
-- Q3
SELECT * FROM Employees
RIGHT JOIN Departments ON 
    Employees.DepartmentID = Departments.DepartmentID;

-- ====================================================
-- Q4

SELECT * FROM Employees
FULL  JOIN Departments ON 
    Employees.DepartmentID = Departments.DepartmentID;

-- ====================================================
-- Q5

SELECT DISTINCT
    Departments.DepartmentName,
    SUM(Salary) OVER (PARTITION BY DepartmentName) AS TotalSalary
FROM Employees
JOIN Departments 
  ON Employees.DepartmentID = Departments.DepartmentID;


-- =======================================
-- Q6

SELECT 
    Departments.DepartmentName,
    Projects.ProjectName
FROM 
    Departments
CROSS JOIN 
    Projects;

-- =====================================
-- Q7

SELECT 
    Employees.EmployeeID,
    Employees.Name,
    Departments.DepartmentName,
    Projects.ProjectName
FROM 
    Employees
LEFT JOIN 
    Departments ON Employees.DepartmentID = Departments.DepartmentID
LEFT JOIN 
    Projects ON Employees.EmployeeID = Projects.EmployeeID;