# 
Get-Module


# Remove after making changes to the module
Remove-Module ImportFramework


# import module from development environment
Import-Module -Name "C:\repos\PowerShell-ETL-Framework\ImportFramework" -Verbose





$CustomerParameters = @{
    RootFolder = "C:\EXTERNAL-FILES\CUSTOMER-1";
}

$CustomerParameters

$csvfilepath = Join-Path $CustomerParameters.RootFolder "IMPORT\customer.csv"
$csvfilepath

#Create-TableScriptFromCsv -CSVFilePath $csvfilepath

Import-CsvCustomerFile @CustomerParameters 









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

