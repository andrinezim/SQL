# Task 4
CREATE TABLE employee_work_hours (
 EmployeeID int, 
 login_hours int, 
 working_date date,
 FOREIGN KEY (EmployeeID) REFERENCES employees(EmployeeID)
);
# SHOW TABLE STATUS WHERE Name = 'employee_work_hours'
# SHOW TABLE STATUS WHERE Name = 'employees'
# ALTER TABLE employees ENGINE = InnoDB;
INSERT INTO employee_work_hours (EmployeeID, login_hours, working_date)
VALUES 
(1, 4, '2022-02-14'),
(1, 4, '2022-02-07'),
 (2, 8, '2022-02-15'),
 (3, 2, '2022-02-10'), 
 (4, 7, '2022-02-10'), 
 (8, 5, '2022-02-13'),
(9, 4, '2022-02-14');

# Task 5
SELECT products.ProductName, suppliers.CompanyName, suppliers.Country, 
suppliers.Phone 
FROM products, suppliers
ORDER BY suppliers.Country DESC
LIMIT 25;

# Task 6
SELECT customers.ContactName, orderdetails.ProductID, orders.OrderDate, 
orderdetails.Quantity FROM customers
INNER JOIN orders
ON customers.customerID = orders.customerID
INNER JOIN orderdetails
ON orders.OrderID = orderdetails.OrderID
WHERE orderdetails.Quantity = (SELECT MAX(Quantity) FROM orderdetails);

# Task 7
/*average purchase quantity per customer belonging to the category ‘Beverages’*/
SELECT AVG(Quantity) AS Average_Quantity_Beverages FROM orderdetails
INNER JOIN products
ON orderdetails.ProductID = products.ProductID
INNER JOIN categories
ON products.CategoryID = categories.CategoryID
WHERE categories.CategoryName = 'Beverages';
/* total sum of all products sold for the category ‘Produce’*/
SELECT SUM(Quantity) AS SUM_Quantity_Produce FROM orderdetails
INNER JOIN products
ON orderdetails.ProductID = products.ProductID
INNER JOIN categories
ON products.CategoryID = categories.CategoryID
WHERE categories.CategoryName = 'Produce';

# Task 8
SELECT products.ProductName, products.UnitPrice, orderdetails.ProductID FROM products
INNER JOIN orderdetails
ON products.ProductID = orderdetails.ProductID
WHERE products.unitprice >= 20
GROUP BY products.ProductName, products.UnitPrice, orderdetails.ProductID 
HAVING COUNT(orderdetails.ProductID) >= 3;

# Task 9
#Option 1, using notes column to find the women:
SELECT e.employeeID, e.FirstName AS `Employee Name`, SUM(ewh.login_hours) AS `Total working hours`
FROM employees AS e
INNER JOIN employee_work_hours AS ewh
ON ewh.EmployeeID = e.EmployeeID
WHERE e.Notes LIKE '%She%' 
GROUP BY e.EmployeeID
HAVING `Total working hours` > 2;
#Option 2, using TitleOfCourtesy to find the women:
SELECT e.employeeID, e.FirstName AS `Employee name`, SUM(ewh.Login_hours) AS `Total 
working hours` 
FROM employees AS e
INNER JOIN employee_work_hours AS ewh
ON ewh.employeeID = e.employeeID
WHERE e.TitleOfCourtesy LIKE '%s.' 
GROUP BY e.EmployeeID
HAVING `Total working hours` > 2;

# Task 10
# SET SQL_SAFE_UPDATES = 0;
DELETE ewh FROM employee_work_hours AS ewh
INNER JOIN employees as e
ON ewh.EmployeeID = e.EmployeeID
WHERE e.BirthDate BETWEEN '1950-01-01' AND '1960-05-27';
