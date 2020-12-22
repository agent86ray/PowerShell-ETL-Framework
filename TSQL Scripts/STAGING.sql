SELECT ', ' + COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'SalesLT'
AND TABLE_NAME = 'Customer'

TRUNCATE TABLE import.customer;

SELECT *
FROM import.customer;


CREATE TABLE [import].[product] ( 
   ["ProductID"] VARCHAR(255)
,  ["ProductNumber"] VARCHAR(255)
,  ["Name"] VARCHAR(255)
,  ["ProductCategoryID"] VARCHAR(255)
,  ["ProductModelID"] VARCHAR(255)
);



TRUNCATE TABLE import.product;

SELECT *
FROM import.product;


TRUNCATE TABLE [import].[services]

SELECT *
FROM [import].[services]

