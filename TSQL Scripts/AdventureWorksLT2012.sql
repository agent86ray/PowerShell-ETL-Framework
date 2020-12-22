CREATE SCHEMA Export
GO

CREATE OR ALTER VIEW Export.CustomerLookup
AS
	SELECT
		[CustomerID]	AS CustomerNumber
	,	CONVERT(VARCHAR(128), [CompanyName]) AS CustomerName
	FROM SalesLT.Customer
GO


CREATE OR ALTER VIEW Export.ProductLookup
AS
	SELECT
		[ProductID]
	,	CONVERT(VARCHAR(25), [ProductNumber]) AS ProductNumber
	,	CONVERT(VARCHAR(50), [Name]) AS [Name]
	,	[ProductCategoryID]
	,	[ProductModelID]
	FROM SalesLT.Product
GO

