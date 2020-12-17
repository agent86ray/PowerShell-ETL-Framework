# 
Get-Module


# Remove after making changes to the module
Remove-Module ImportFramework


Get-Help Import-Module -Online

# import module from development environment
Import-Module -Name "C:\repos\PowerShell-ETL-Framework\ImportFramework"


Get-ImportFrameworkConfiguration




# import any csv files found; will create table if it doesn't exist
# application name is schema name
$csvfiles = Import-CsvToStaging -ApplicationName "CRM"
$csvfiles | Get-Member


Get-ImportFrameworkVersion


Get-ImportFrameworkConfiguration


Initialize-ImportApplication -ApplicationName "CRM"


# remove the log file to test creating it







$modulepaths = @()
$modulepaths = $env:PSModulePath -Split ";"
$HOMEMODULEFOLDER = $modulepaths[0]

