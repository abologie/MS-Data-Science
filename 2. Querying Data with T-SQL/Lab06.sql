-- Challenge 1: Retrieve Product Price Information
---- 1. Retrieve products whose list price is higher than the average unit price
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice > 
	(SELECT AVG(UnitPrice)
	FROM SalesLT.SalesOrderDetail)
ORDER BY ProductID
---- 2. Retrieve Products with a list price of $100 or more that have been sold for less than $100
SELECT p.ProductID, p.Name, p.ListPrice
FROM SalesLT.Product AS p
WHERE ProductID IN 
	(SELECT ProductID 
	FROM SalesLT.SalesOrderDetail AS sod 
	WHERE p.ListPrice >= 100 AND sod.UnitPrice < 100)
ORDER BY ProductID
---- 3. Retrieve the cost, list price, and average selling price for each product
SELECT p.ProductID, p.Name, p.StandardCost, p.ListPrice, 
	(SELECT AVG(sod.UnitPrice)
	FROM SalesLT.SalesOrderDetail AS sod
	WHERE ProductID = p.ProductID) AS AveragePrice
FROM SalesLT.Product AS p
ORDER BY p.ProductID
---- 4. Retrieve products that have an average selling price that is lower than the cost
SELECT p.ProductID, p.Name, p.StandardCost, p.ListPrice, 
	(SELECT AVG(sod.UnitPrice)
	FROM SalesLT.SalesOrderDetail AS sod
	WHERE ProductID = p.ProductID) AS AveragePrice
FROM SalesLT.Product AS p
WHERE p.StandardCost > 
	(SELECT AVG(sod.UnitPrice)
	FROM SalesLT.SalesOrderDetail AS sod
	WHERE ProductID = p.ProductID)
ORDER BY p.ProductID

-- Challenge 2: Retrieve Customer Information
---- 1. Retrieve customer information for all sales orders
SELECT soh.SalesOrderID, soh.CustomerID, ci.FirstName, ci.LastName, soh.TotalDue
FROM SalesLT.SalesOrderHeader AS soh
CROSS APPLY dbo.ufnGetCustomerInformation(soh.CustomerID) AS ci
ORDER BY soh.SalesOrderID
---- 2. Retrieve customer address information
SELECT ca.CustomerID, ci.FirstName, ci.LastName, a.AddressLine1, a.City
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(ca.CustomerID) AS ci
ORDER BY ca.CustomerID