# 
Get-Module


# Remove after making changes to the module
Remove-Module ImportFramework


# import module from development environment
Import-Module -Name "C:\repos\PowerShell-ETL-Framework\ImportFramework"


Create-TableScriptFromCsv -CSVFilePath "C:\IMPORT\CUSTOMER-2\customer.csv"


Import-CsvFileList -RootFolder "C:\IMPORT\CUSTOMER-2"







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

