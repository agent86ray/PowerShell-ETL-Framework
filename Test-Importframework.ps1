# 
Get-Module


#
Get-Module -ListAvailable | Export-Excel -Now


# Remove after making changes to the module
Remove-Module ImportFramework


# import module directly from development environment
# for deployment put module in ImportFramework folder
# under C:\Program Files\WindowsPowerShell\Modules
Import-Module -Name "C:\repos\PowerShell-ETL-Framework\ImportFramework" -Verbose


######################################################################

# truncate the staging tables
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    Query = "TRUNCATE TABLE staging.import.customer;";
}
Invoke-Sqlcmd @sqlparameters 

$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    Query = "TRUNCATE TABLE staging.import.product;";
}
Invoke-Sqlcmd @sqlparameters 
######################################################################


# show the configuration stored in the module
Get-ImportFrameworkConfiguration


# parameter hash table
$CustomerParameters = @{
    RootFolder = "C:\EXTERNAL-FILES\CUSTOMER-1";
}

Create-CustomerImportFolder @CustomerParameters


# get the IMPORT folder path
Get-CsvCustomerPath @CustomerParameters


# get the list of CSV files ready for import
Get-AvailableCsvCustomerFile @CustomerParameters


# import all CSV files available into staging tables
Import-CsvCustomerFile @CustomerParameters


$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "STAGING";
    SchemaName="import";
}

# SELECT * FROM import.customer
Read-SqlTableData -TableName "customer" @sqlparameters

# SELECT * FROM import.product
Read-SqlTableData -TableName "product" @sqlparameters


# show quick and dirty generate CREATE staging table script
# from CSV file with column names in first row
$csvfilepath = Join-Path $CustomerParameters.RootFolder "IMPORT\product.csv"
Create-TableScriptFromCsv -CSVFilePath $csvfilepath

