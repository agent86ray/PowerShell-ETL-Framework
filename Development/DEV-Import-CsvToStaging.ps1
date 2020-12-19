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

# parameters
[string] $ApplicationName = "CRM"

# Get the ApplicationFolder to import CSV files
$ApplicationFolder = Join-Path $version["RootPath"] $ApplicationName

# Get list of CSV file names to import
$filelist = Get-ChildItem -Path $ApplicationFolder "*.csv" | 
    Select-Object -Property Name

# Get the count of CSV files in the folder
[int] $count = $filelist | Measure-Object | Select-Object -ExpandProperty Count

if ($count -eq 0) {
    "TO DO: set exit code and return from cmdlet"
}


$filelist | ForEach-Object { Write-Output $_.Name } 

