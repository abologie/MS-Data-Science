-- Challenge 1: Creating scripts to insert sales orders
---- 1. Write code to insert an order header
CREATE SEQUENCE SalesLT.SalesOrderNumber AS INT
START WITH 71950
INCREMENT BY 1

DECLARE @orderID INT
DECLARE @orderDate datetime = GETDATE()  
DECLARE @dueDate datetime = DATEADD(dd, 7, GETDATE());
DECLARE @customerID int = 1;

SET IDENTITY_INSERT SalesLT.SalesOrderHeader ON
SET @orderID = NEXT VALUE FOR SalesLT.SalesOrderNumber;
INSERT INTO SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
VALUES 
	(@orderID, @orderDate, @dueDate, @customerID, 'CARGO TRANSPORT 5')
SET IDENTITY_INSERT SalesLT.SalesOrderHeader OFF
PRINT @orderID
---- 2. Write code to insert an order detail
DECLARE @salesOrderID int = 71952
DECLARE @productID int = 760
DECLARE @quantity int = 1
DECLARE @unitPrice money = 782.99

IF EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @salesOrderID)
BEGIN
	INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
	VALUES
		(@salesOrderID, @quantity, @productID, @unitPrice)
END
ELSE
BEGIN
	PRINT 'The order does not exist'
END

-- Challenge 2: Updating Bike Prices
---- 1. Write a WHILE loop to update bike prices
DECLARE @marketAvg money = 2000;
DECLARE @marketMax money = 5000;
DECLARE @currentAvg money;
DECLARE @currentMax money;

SELECT @currentAvg =  AVG(ListPrice), @currentMax = MAX(ListPrice)
FROM SalesLT.Product
WHERE ProductCategoryID IN
	(SELECT DISTINCT ProductCategoryID
	FROM SalesLT.vGetAllCategories
	WHERE ParentProductCategoryName = 'Bikes');

WHILE @currentAvg < @marketAvg
BEGIN
	UPDATE SalesLT.Product
    SET ListPrice = ListPrice * 1.1
    WHERE ProductCategoryID IN
		(SELECT DISTINCT ProductCategoryID
		FROM SalesLT.vGetAllCategories
		WHERE ParentProductCategoryName = 'Bikes')
	  
	SELECT @currentAvg =  AVG(ListPrice), @currentMax = MAX(ListPrice)
	FROM SalesLT.Product
	WHERE ProductCategoryID IN
	(SELECT DISTINCT ProductCategoryID
	 FROM SalesLT.vGetAllCategories
	 WHERE ParentProductCategoryName = 'Bikes');

   IF @currentMax >= @marketMax
    BEGIN
	  BREAK
	END
END