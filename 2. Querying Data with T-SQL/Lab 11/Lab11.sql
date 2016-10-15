-- Challenge 1: Logging Errors
---- 1. Throw an error for non-existent orders
DECLARE @SalesOrderID int = 0
IF NOT EXISTS (SELECT SalesOrderID FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
BEGIN 
	DECLARE @error varchar(1000)
	SET @error = 'Order ID ' + CAST(@SalesOrderID AS varchar) + ' does not exist.';
	THROW 50001, @error, 0
END

DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID
GO
---- 2. Handle errors
DECLARE @SalesOrderID int = 0
BEGIN TRY
	IF NOT EXISTS (SELECT SalesOrderID FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
	BEGIN 
		DECLARE @error varchar(1000)
		SET @error = 'Order ID ' + CAST(@SalesOrderID AS varchar) + ' does not exist.';
		THROW 50001, @error, 0
	END

	DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID
	DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH
GO

-- Challenge 2: Ensuring Data Consistency
---- 1. Implement a transaction
DECLARE @SalesOrderID int = 71935
BEGIN TRY
	IF NOT EXISTS (SELECT SalesOrderID FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
	BEGIN 
		DECLARE @error varchar(1000)
		SET @error = 'Order ID ' + CAST(@SalesOrderID AS varchar) + ' does not exist.';
		THROW 50001, @error, 0
	END

	BEGIN TRANSACTION
		DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
		THROW 50001, 'error', 1
		DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF (@@TRANCOUNT > 0)
	BEGIN
		ROLLBACK TRANSACTION;
		THROW
	END
	ELSE
	BEGIN
		PRINT ERROR_MESSAGE()
	END
END CATCH