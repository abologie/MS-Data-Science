-- Challenge 1: Retrieve Customer Data
---- 1. Retrieve customer details
SELECT *
FROM SalesLT.Customer
---- 2. Retrieve customer name data
SELECT Title, FirstName, MiddleName, LastName, Suffix 
FROM SalesLT.Customer
---- 3. Retrieve customer names and phone numbers
SELECT SalesPerson, Title + ' ' + LastName AS CustomerName, Phone 
FROM SalesLT.Customer

-- Challenge 2: Retrieve Customer and Sales Data
---- 1. Retrieve a list of customer companies
SELECT CAST(CustomerID AS varchar) + ': ' + CompanyName AS Company 
FROM SalesLT.Customer
---- 2. Retrieve a list of sales order revisions
SELECT CAST(SalesOrderNumber AS varchar) + ' (' + CAST(RevisionNumber AS varchar) + ')' AS OrderRevision, CONVERT(nvarchar(30), OrderDate, 102) AS OrderDate 
FROM SalesLT.SalesOrderHeader

-- Challenge 3: Retrieve Customer Contact Details
---- 1. Retrieve customer contact names with middle names if known
SELECT FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS FullName 
FROM SalesLT.Customer
---- 2. Retrieve primary contact details
UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1; 

SELECT CustomerID, ISNULL(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer
---- 3. Retrieve shipping status
UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899

SELECT SalesOrderID, OrderDate,
	CASE
		WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
		ELSE 'Shipped'
	END AS ShippingStatus
FROM SalesLT.SalesOrderHeader