SELECT ', ' + COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'SalesLT'
AND TABLE_NAME = 'Customer'

TRUNCATE TABLE import.customer;

SELECT *
FROM import.customer;


TRUNCATE TABLE [import].[services]

SELECT *
FROM [import].[services]

