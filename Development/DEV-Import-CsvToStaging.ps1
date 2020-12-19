# develop Import-CsvToStaging


# Version information
$version = @{
    Version = "1.1.0";
    RootPath = "C:\IMPORT";
    LogFolder = "C:\IMPORT";
    LogFile = "ImportFramework.Log";
    LogFilePath = Join-Path "C:\IMPORT" "ImportFramework.Log";
}

$version

# SQL Server parameters
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "staging";
    SchemaName = "dbo"
    Force=$true
}





# parameters
[string] $ApplicationName = "CRM"

# Get the ApplicationFolder to import CSV files
$ApplicationFolder = Join-Path $version["RootPath"] $ApplicationName

# Get list of CSV file names to import
$filelist = Get-ChildItem -Path $ApplicationFolder "*.csv" | 
    Select-Object -Property Name

# Selected.System.IO.FileInfo
$filelist | Get-Member

# Get the count of CSV files in the folder
[int] $count = $filelist | Measure-Object | Select-Object -ExpandProperty Count

if ($count -eq 0) {
    "TO DO: set exit code and return from cmdlet"
}

$filelist | Join-Path $_.DirectoryName $_.Name



$CSVFullPathList = $filelist | Resolve-Path $_.Name

$CSVFullPath | ForEach-Object { Import-CsvToStaging -CSVFileName $_.Path }

$csvfile = $CSVFullPath | Select-Object -First 1







