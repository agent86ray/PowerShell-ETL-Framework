# sqlserver module was created by Microsoft. For documentation see
# https://docs.microsoft.com/en-us/powershell/module/sqlserver/?view=sqlserver-ps


# I used PowerShell v5.1
$PSVersionTable


# available for download from the PowerShell gallery
Find-Module sqlserver


# you can install directly from the PowerShell gallery 
Find-Module sqlserver | Install-Module


# Check if the sqlserver module is in the session
Get-Module 


# load module if necessary
Import-Module "sqlserver"


# Get info about the SQL Server instance. 
$sqlinstance = Get-SqlInstance -ServerInstance "DESKTOP-CH7B7GJ\SQL2019DEV"
$sqlinstance


# Returns TYPE: Microsoft.SqlServer.Management.Smo.Server
# Shows properties, methods, etc.
$sqlinstance | Get-Member


# show SQL Server version info
$sqlinstance.ServerVersion


# create a hash table of the parameters required
# truncate table
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    Query = "TRUNCATE TABLE staging.import.services;";
}

# Execute T-SQL
Invoke-Sqlcmd @sqlparameters 


# create a hash table for the parameters required
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "staging";
    SchemaName = "import";
    TableName = "services";
    # not working on my laptop
    # Force=$true;
}

# view the hash table
$sqlparameters


# Query the services table
Read-SqlTableData @sqlparameters | Out-GridView


# Insert rows from CSV into table. -Force will create anything that
# doesn't exist; e.g. database, schema, table
# Get parameters from $sqlparameters hash table; specify the hash
# table as a parameter by prefixing variable name with "@"
Get-Service | Export-Csv -Path C:\temp\service.csv
Import-Csv -Path C:\temp\service.csv | Write-SqlTableData @sqlparameters -Force



# When -Force creates a table, every column type is NVARCHAR(MAX)
# Let it create a table with just 1 row then manually change the
# create table script to varchar(255)
Import-Csv -Path C:\temp\service.csv | 
Select-Object -First 1 |
Write-SqlTableData @sqlparameters -Force

# script create table using SSMS and change column type to varchar(255)
# execute create table script




#######################################################################









# Check the status of the SQL Server Browser service
Get-Service | Where-Object { $_.DisplayName -like "*sql*" }


Start-Service "SQLBrowser"


# if fails check if its start type and status
Get-Service "SQLBrowser" | Select-Object "StartType", "Status"

Get-Service "SQLBrowser" | Select-Object "StartType", "Status" | Get-Member

# if start type = disabled then set it to automatic or manual
Set-Service -Name "SQLBrowser" -StartupType Manual

# start the service
Start-Service "SQLBrowser"


