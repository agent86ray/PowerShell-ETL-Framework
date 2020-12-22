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


# Get the list of PowerShell modules available
Get-Module -ListAvailable


# load module if necessary (I don't think it is)
Import-Module "sqlserver"


# Get info about the SQL Server instance. 
$sqlinstance = Get-SqlInstance -ServerInstance "DESKTOP-CH7B7GJ\SQL2019DEV"
$sqlinstance

# Returns TYPE: Microsoft.SqlServer.Management.Smo.Server
# Shows properties, methods, etc.
$sqlinstance | Get-Member

# show SQL Server version info
$sqlinstance.ServerVersion


# create a hash table of the parameters required to execute a 
# T-SQL command using the Invoke-Sqlcmd cmdlet.
# I think it's easier than putting them on the command line.
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    Query = "TRUNCATE TABLE staging.import.customer;";
}

# Execute T-SQL command to truncate a table
# Get parameters from $sqlparameters hash table; specify the hash
# table as a parameter by prefixing variable name with "@"
Invoke-Sqlcmd @sqlparameters 


# create a hash table for the parameters
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

# Insert rows from CSV into table. -Force will create anything that
# doesn't exist; e.g. database, schema, table
Get-Service | Export-Csv -Path C:\temp\service.csv
Import-Csv -Path C:\temp\service.csv | Write-SqlTableData @sqlparameters -Force


# Query the services table
Read-SqlTableData @sqlparameters | Out-GridView


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


