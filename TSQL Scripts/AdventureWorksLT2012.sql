CREATE SCHEMA Export
GO

CREATE VIEW Export.CustomerLookup
AS
	SELECT
		[CustomerID]	AS CustomerNumber
	,	CONVERT(VARCHAR(128), [CompanyName]) AS CustomerName
	FROM SalesLT.Customer
GO

