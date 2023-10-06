/* Task 1 */
SELECT * FROM categories;

/* Task 2 */
SELECT ProductName, QuantityPerUnit, UnitPrice FROM products;

/* Task 3 */
SELECT products.ProductName, products.SupplierID, suppliers.CompanyName
FROM products, suppliers
WHERE products.SupplierID = suppliers.SupplierID;

# Alternativ løsning:
/*SELECT products.ProductName, products.SupplierID, suppliers.CompanyName
FROM products
INNER JOIN suppliers ON products.SupplierID = suppliers.SupplierID;*/

/* Task 4 */
SELECT * FROM orders
WHERE OrderDate = '1996-05-17';

/* Task 5 */
SELECT products.ProductName, orders.* FROM orders, products
WHERE products.ProductName = "Geitost";

/* Task 6 */
SELECT ProductName, UnitPrice FROM products
WHERE UnitPrice > 40;

/* Task 7 */ 
SELECT * FROM products
WHERE UnitPrice <= 40;

/* Task 8 */
SELECT OrderID, ContactName FROM orders, customers;

/* Task 9 */
SELECT ContactName, Address, City, Orderdate FROM customers, orders
WHERE OrderDate = '1995-05-01';

/* Task 10 */
SELECT FirstName, LastName, OrderID FROM employees, orders 
WHERE OrderID = 10369
AND employees.EmployeeID = orders.EmployeeID; 

/* Task 11 */
SELECT * FROM customers 
WHERE City = 'London' OR City = 'Buenos Aires';

/* Task 12 */
SELECT ContactName, Country FROM customers
WHERE ContactName
BETWEEN 'M%' AND 'S%' AND NOT country = 'México';

/* Task 13 */
SELECT CustomerID, City, Address FROM customers
ORDER BY CustomerID;

/* Task 14 */
SELECT * FROM products
WHERE UnitPrice < 10 
AND (QuantityPerUnit = '500 g' 
OR NOT QuantityPerUnit = '24 - 12 oz bottles')
ORDER BY ProductName DESC;

/* Task 15 */
SELECT ProductName, SupplierID, UnitPrice FROM products
ORDER BY SupplierID DESC, UnitPrice