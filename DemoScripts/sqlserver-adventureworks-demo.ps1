# sqlserver demo

$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "AdventureWorksLT2012";
    SchemaName="SalesLT";
}

# SELECT * FROM SalesLT.Customer
Read-SqlTableData -TableName "Customer" @sqlparameters


$viewparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "AdventureWorksLT2012";
    SchemaName="Export";
}


# create customer csv file from view
$exportcsvfilename = "C:\EXTERNAL-FILES\CUSTOMER-1\IMPORT\customer.csv"
Read-SqlViewData -ViewName "CustomerLookup" -TopN 50 @viewparameters |
    Export-Csv -Path $exportcsvfilename -NoTypeInformation

