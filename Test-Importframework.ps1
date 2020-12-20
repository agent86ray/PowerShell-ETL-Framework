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


# show the configuration stored in the module
Get-ImportFrameworkConfiguration




$CustomerParameters = @{
    RootFolder = "C:\EXTERNAL-FILES\CUSTOMER-1";
}

$CustomerParameters


Create-CustomerImportFolder @CustomerParameters


Get-CsvCustomerPath @CustomerParameters


# get the list of CSV files ready for import
Get-AvailableCsvCustomerFile @CustomerParameters


# import all CSV files available into staging tables
Import-CsvCustomerFile @CustomerParameters


# show quick and dirty generate CREATE staging table script
# from CSV file with column names in first row
$csvfilepath = Join-Path $CustomerParameters.RootFolder "IMPORT\customer.csv"
$csvfilepath
Create-TableScriptFromCsv -CSVFilePath $csvfilepath

$tablename = "customer"


$csvfilename = Split-Path -Path $csvfilepath -Leaf
[string] $timestamp = (Get-Date).ToFileTimeUtc()
$filenameplustimestamp = $tablename + "_" + $timestamp
$archivefilename = $csvfilename -replace $tablename, $filenameplustimestamp
$archivefoldername = (Split-Path -Path $csvfilepath) -replace "IMPORT", "ARCHIVE"
Join-Path $archivefoldername $archivefilename


  
$csvfilepath -replace $tablename, $archivefilename










Get-ImportFrameworkConfiguration


Get-Command -Module ImportFramework



Import-CsvToStaging -CSVFileName "customer.csv"



Get-ImportFrameworkVersion


Get-ImportFrameworkConfiguration


Initialize-ImportApplication -ApplicationName "CRM"


# remove the log file to test creating it







$modulepaths = @()
$modulepaths = $env:PSModulePath -Split ";"
$HOMEMODULEFOLDER = $modulepaths[0]

