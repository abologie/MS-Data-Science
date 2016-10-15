-- Challenge 1: Retrieve Regional Sales Totals
---- 1. Retrieve totals for country/region and state/province
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince
---- 2. Indicate the grouping level in the results
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue, (IIF(GROUPING_ID(a.CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1, 'Total', IIF(GROUPING_ID(a.StateProvince) = 1, a.CountryRegion + ' Subtotal', a.StateProvince + ' Subtotal'))) AS Level
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince
---- 3. Add a grouping level for cities
SELECT a.CountryRegion, a.StateProvince, a.City, SUM(soh.TotalDue) AS Revenue, (IIF(GROUPING_ID(a.CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1 AND GROUPING_ID(a.City) = 1, 'Total', IIF(GROUPING_ID(a.StateProvince) = 1 AND GROUPING_ID(a.City) = 1, a.CountryRegion + ' Subtotal', IIF(GROUPING_ID(a.City) = 1, a.StateProvince + ' Subtotal', a.City + ' Subtotal')))) AS Level
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, a.City

-- Challenge 2: Retrieve Customer Sales Revenue by Category
---- 1. Retrieve customer sales revenue for each parent category
SELECT *
FROM 
	(SELECT ParentProductCategoryName, CompanyName, LineTotal
	FROM SalesLT.Customer AS c
	JOIN SalesLT.SalesOrderHeader AS soh
	ON c.CustomerID = soh.CustomerID
	JOIN SalesLT.SalesOrderDetail AS sod
	ON soh.SalesOrderID = sod.SalesOrderID
	JOIN SalesLT.Product AS p
	ON sod.ProductID = p.ProductID
	JOIN SalesLT.vGetAllCategories AS cat
	ON p.ProductCategoryID = cat.ProductCategoryID) AS sales
PIVOT (SUM(LineTotal) FOR ParentProductCategoryName IN ([Accessories], [Bikes], [Clothing], [Components])) AS pivoted
ORDER BY CompanyName