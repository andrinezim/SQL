# Solution using CREATE VIEW and WITH clause:
/* TASK 1 */

-- A view of all orders with paymentamount calculated by multiplying UnitPrice and Quantity
CREATE VIEW order_payments
AS
SELECT od.OrderID, c.CustomerID, c.ContactName, SUM(od.UnitPrice * od.Quantity (1-
od.Discount)) AS `Customer spending` FROM orderdetails od
JOIN orders o
ON od.OrderID = o.OrderID
JOIN customers c
ON o.CustomerID = c.CustomerID
GROUP BY od.OrderID;
-- Using a WITH clause to extract the customers and their sales potential
WITH totalPayments(ContactName, `Customer spending`) AS
-- Summing up total payment for each customer
 (SELECT ContactName, SUM(`Customer spending`)
 FROM order_payments
 GROUP BY ContactName),
ContactNameAvg(avgPayment) AS 
 -- Calculating the average payment for an order, and adding the value to the attribute avgPayment
 (SELECT AVG(`Customer spending`)
 FROM order_payments)
 SELECT ContactName, `Customer spending`,
-- Adding a column containing sales potential based on each customer's spending

CASE
WHEN `Customer spending` > avgPayment THEN 'High Sales Potential'
 ELSE 'Average Sales Potential'
END AS `Customer sales potential`
 FROM totalPayments, ContactNameAvg
 -- Ordering by each customer's spending to get an overview
 ORDER BY `Customer spending`;
 
# Solution using Subqueries:
# --Select companyname and the total spending
SELECT c.CompanyName, SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) AS `Total Spending` ,
#--Adding the last column using a clause
CASE
WHEN SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) > (SELECT 
AVG(od.Quantity*od.UnitPrice*(1-od.Discount)) FROM orderdetails AS od) THEN "High Sales 
Potential"
ELSE "Average Sales Potenial" 
END AS `Customer Sales Potential`
FROM customers AS c
INNER JOIN orders AS o
ON c.CustomerID = o.CustomerID
INNER JOIN orderdetails AS od
ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY `Total Spending`;

/* TASK 2 */
-- Write queries to fetch the productname, price and quantity along with the usage of following operators.
-- 2.1: a bitwise or with price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice | od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.2: a bitwise and with price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice & od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.3: Product of price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice * od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.4: Sum of price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice + od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.5: Modulus between price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice % od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.6: Division of price by quantity
SELECT p.ProductName, IFNULL(od.UnitPrice / od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

/* Everything in one table */
CREATE VIEW `Comparing UnitPrice and Quantity` AS
SELECT p.ProductName, IFNULL(od.UnitPrice | od.Quantity, 'None') AS `OR`, 
IFNULL(od.UnitPrice & od.Quantity, 'None') AS `AND`, IFNULL(od.UnitPrice * 
od.Quantity, 'None') AS `Product`,
IFNULL(od.UnitPrice + od.Quantity, 'None') AS `SUM`, IFNULL(od.UnitPrice % 
od.Quantity, 'None') AS `Modulus`,
 IFNULL(od.UnitPrice / od.Quantity, 'None') AS `Division` FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;
SELECT * FROM `Comparing UnitPrice and Quantity`;