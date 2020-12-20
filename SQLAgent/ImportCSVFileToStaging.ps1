
$Folder = "C:\repos\PowerShell-ETL-Framework\SQLAgent"
$LogFile = Join-Path $Folder "Log.txt"


# reports Microsoft.PowerShell.Utility as the only module loaded 
Get-Module | Out-File -FilePath $LogFile -Append


Import-Module "sqlserver"
Import-Module "ImportFramework"


$CustomerParameters = @{
    RootFolder = "C:\EXTERNAL-FILES\CUSTOMER-1";
}

# import all CSV files available into staging tables
Import-CsvCustomerFile @CustomerParameters


