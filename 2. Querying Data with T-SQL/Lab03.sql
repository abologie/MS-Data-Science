-- Challenge 1: Generate Invoice Reports
---- 1. Retrieve customer orders
SELECT c.CompanyName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
---- 2. Retrieve customer orders with addresses
SELECT c.CompanyName, a.AddressLine1, a.AddressLine2, a.City, a.StateProvince, a.PostalCode, a.CountryRegion, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
ON a.AddressID = ca.AddressID
JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
WHERE ca.AddressType = 'Main Office'

-- Challenge 2: Retrieve Sales Data
---- 1. Retrieve a list of all customers and their orders
SELECT c.CompanyName, c.FirstName, c.LastName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader oh
ON oh.CustomerID = c.CustomerID
ORDER BY oh.SalesOrderID DESC
---- 2. Retrieve a list of customers with no address
SELECT c.CustomerID, c.CompanyName, c.FirstName, c.LastName, c.Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressID IS NULL
---- 3. Retrieve a list of customers and products without orders
SELECT c.CustomerID, p.ProductID
FROM SalesLT.Customer AS c
FULL JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
FULL JOIN SalesLT.SalesOrderDetail AS od
ON oh.SalesOrderID = od.SalesOrderID
FULL JOIN SalesLT.Product AS p
ON od.ProductID = p.ProductID
WHERE oh.SalesOrderID IS NULL
ORDER BY p.ProductID, c.CustomerID