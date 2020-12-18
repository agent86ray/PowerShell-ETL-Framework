# Check if the sqlserver module is in the session
Get-Module 


# load to a SQL Server table using SqlServer module
# https://docs.microsoft.com/en-us/powershell/module/sqlserver/?view=sqlserver-ps

Import-Module "sqlserver"


Get-SqlInstance -ServerInstance "DESKTOP-CH7B7GJ\SQL2019DEV"


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


# create a hash table of the parameters required
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "staging";
    SchemaName = "import";
    TableName = "services"
}

# view the hash table
$sqlparameters


# Insert rows from CSV into table. -Force will create anything that
# doesn't exist; e.g. database, schema, table
# Get parameters from $sqlparameters hash table; specify the hash
# table as a parameter by prefixing variable name with "@"
Import-Csv -Path C:\temp\service.csv | Write-SqlTableData @sqlparameters -Force


# When -Force creates a table, every column type is NVARCHAR(MAX)
# Let it create a table with just 1 row then manually change the
# create table script to varchar(255)
Import-Csv -Path C:\temp\service.csv | 
Select-Object -First 1 |
Write-SqlTableData @sqlparameters -Force

# script create table using SSMS and change column type to varchar(255)
# execute create table script


# create a hash table of the parameters required
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "staging";
    SchemaName = "import";
    TableName = "services"
}

# Query the services table
Read-SqlTableData @sqlparameters | Out-GridView



# create a hash table of the parameters required
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    Query = "TRUNCATE TABLE staging.import.services;";
}
$sqlparameters

# Execute T-SQL
Invoke-Sqlcmd @sqlparameters 

