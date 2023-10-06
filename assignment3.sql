# Task 1
SELECT * FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID;

# Task 2
SELECT ProductName, QuantityPerUnit, Quantity FROM products p
JOIN orderdetails od
ON p.ProductID = od.ProductID
WHERE Quantity > 20;

# Task 3
SELECT OrderID, ContactName, Country FROM orders o
JOIN customers c
ON o.CustomerID = c.CustomerID
ORDER BY Country DESC;

# Task 4
SELECT ContactName, CompanyName, OrderID, OrderDate FROM orders o
JOIN customers c
ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = "1995-09-01";

# Task 5
SELECT OrderID, ContactName, City, EmployeeID from orders o
JOIN customers c
ON o.CustomerID = c.CustomerID
WHERE o.EmployeeID BETWEEN 2 AND 6
ORDER BY City;

# Task 6
SELECT OrderID, OrderDate, c.PostalCode, ContactName, CONCAT(FirstName, ' ', LastName) 
AS `Employee Name`, Photo FROM orders o
JOIN customers c
ON o.CustomerID = c.CustomerID
JOIN employees e
ON o.EmployeeID = e.EmployeeID;

# Task 7
SELECT ContactName, o.* FROM customers c
LEFT JOIN orders o
ON o.CustomerID = c.CustomerID
ORDER BY ContactName;

# Task 8
SELECT COUNT(OrderID) AS `Total number of orders` FROM orders;

# Task 9
SELECT ProductID, COUNT(OrderID) AS `Number of orders` FROM orderdetails
GROUP BY ProductID;

# Task 10
SELECT p.ProductName, od.ProductID, COUNT(od.OrderID) AS `Number of orders` FROM 
orderdetails as od
LEFT JOIN products as p
ON od.ProductID = p.ProductID
GROUP BY od.ProductID
HAVING `Number of orders` > 6
ORDER BY `Number of orders` DESC;

# Task 11
SELECT c.CompanyName AS `Customer Name`, COUNT(o.OrderID) AS `Number of orders` 
FROM orders AS o
LEFT JOIN customers AS c
ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID
ORDER BY `Number of orders` DESC;

# Task 12
SELECT * FROM Customers 
WHERE PostalCode IN (SELECT PostalCode FROM Customers GROUP BY PostalCode HAVING 
COUNT(*)>1)
ORDER BY Country ASC;

# Task 13
SELECT DISTINCT Country FROM customers AS c
WHERE NOT EXISTS (SELECT Country FROM suppliers AS s WHERE c.Country = s.Country);

# Task 14
SELECT c.ContactName, COUNT(o.OrderID) AS `Number of orders` FROM orders as o
RIGHT JOIN customers as c
ON c.CustomerID = o.CustomerID
WHERE OrderDate LIKE '1994%'
GROUP BY c.ContactName;

# Task 15
SELECT DISTINCT e.EmployeeID, e.FirstName, COUNT(o.OrderID) AS `Quantity of orders per 
employee` FROM employees e
JOIN orders o
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID
ORDER BY `Quantity of orders per employee` DESC