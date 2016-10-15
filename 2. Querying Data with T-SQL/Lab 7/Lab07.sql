-- Challenge 1: Retrieve Product Information
---- 1. Retrieve product model descriptions
SELECT p.ProductID, p.Name AS ProductName, pmcd.Name AS Model, pmcd.Summary
FROM SalesLT.Product AS p
JOIN SalesLT.vProductModelCatalogDescription AS pmcd
ON p.ProductModelID = pmcd.ProductModelID
ORDER BY p.ProductID
---- 2. Create a table of distinct colors
DECLARE @colors AS TABLE 
	(Color varchar(50))

INSERT INTO @colors
	SELECT DISTINCT Color
	FROM SalesLT.Product

SELECT ProductID, Name AS ProductName, Color
FROM SalesLT.Product
WHERE Color IN 
	(SELECT Color 
	FROM @colors)
---- 3. Retrieve product parent categories
SELECT p.ProductID, p.Name AS ProductName, c.ParentProductCategoryName AS ParentCategory, c.ProductCategoryName AS Category
FROM SalesLt.Product AS p
JOIN dbo.ufnGetAllCategories() AS c
ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY p.ProductID

-- Challenge 2: Retrieve Customer Sales Revenue
---- 1. Retrieve sales revenue by customer and contact
WITH CustomerSales(CompanyContactName, Revenue)
AS 
(SELECT c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')', soh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID)
SELECT CompanyContactName, SUM(Revenue) AS Revenue
FROM CustomerSales
GROUP BY CompanyContactName