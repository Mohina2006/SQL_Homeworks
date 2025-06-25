DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Products

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');
-- ==================================
-- Q1
SELECT 
    Customers.CustomerID,
    Customers.CustomerName,
    Orders.OrderID,
    Orders.OrderDate
FROM 
    Customers
LEFT JOIN 
    Orders 
ON 
    Orders.CustomerID = Customers.CustomerID;

-- ==========================================
-- Q2

SELECT Customers.CustomerID, Customers.CustomerName 
FROM Customers
LEFT JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
WHERE OrderID IS NULL;

-- ===========================================
-- Q3

SELECT OrderDetails.OrderID, Products.ProductName, OrderDetails.Quantity
FROM OrderDetails JOIN Products
ON OrderDetails.ProductID = Products.ProductID

-- ==========================================
-- Q4

SELECT Customers.CustomerID, Customers.CustomerName FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName
HAVING COUNT(Customers.CustomerID) > 1

-- =============================================
-- Q5
SELECT 
    od.OrderID,
    p.ProductName,
    od.Price,
    MAX(od.Price) OVER (PARTITION BY od.OrderID) AS MostExpensiveInOrder
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID;

-- ===========================================
-- Q6
SELECT CustomerID, CustomerName, OrderID, OrderDate
FROM (
    SELECT 
        Customers.CustomerID,
        Customers.CustomerName,
        Orders.OrderID,
        Orders.OrderDate,
        ROW_NUMBER() OVER (PARTITION BY Customers.CustomerID ORDER BY Orders.OrderDate DESC) AS rn
    FROM Customers
    JOIN Orders ON Customers.CustomerID = Orders.CustomerID
) AS LatestOrders
WHERE rn = 1;


-- ===================================================================
-- Q7
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE c.CustomerID NOT IN (
    SELECT c2.CustomerID
    FROM Customers c2
    JOIN Orders o2 ON c2.CustomerID = o2.CustomerID
    JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
    JOIN Products p2 ON od2.ProductID = p2.ProductID
    WHERE p2.Category != 'Electronics'
);


-- ================================================
-- Q8

SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Stationery';

-- ============================================
-- Q9
SELECT 
    c.CustomerID, 
    c.CustomerName, 
    SUM(od.Quantity * od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;