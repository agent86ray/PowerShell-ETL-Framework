
# Version information
$version = @{
    Version = "1.1.0";
    RootPath = "C:\IMPORT";
    LogFolder = "C:\IMPORT"
    LogFile = "ImportFramework.Log"
    LogFilePath = Join-Path "C:\IMPORT" "ImportFramework.Log"
}


# SQL Server parameters
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "staging";
}


function Get-ImportFrameworkConfiguration {

    $version
    $sqlparameters
}


function Get-ImportApplication {
    
    Get-ChildItem -Path $version["RootPath"] -Attributes "Directory"
}


function Initialize-ImportApplication {
    Param (
        [Parameter()]
            [string] $ApplicationName
    )

    $ApplicationFolder = Join-Path $version["RootPath"] $ApplicationName

    If (!(Test-Path $ApplicationFolder)) {
        New-Item -Path $version["RootPath"] -Name $ApplicationName -ItemType "Directory" | Out-Null
        Log-ImportFramework -Message "Application $ApplicationName created"
    }
}


function Import-CsvToStaging {
    Param (
        [Parameter()]
            [string] $CSVFileName
    )

    $CSVFileName
}


function Import-CsvApplicationFile {
    Param (
        [Parameter()]
            [string] $ApplicationName
    )

    $ApplicationFolder = Join-Path $version["RootPath"] $ApplicationName
    $filelist = Get-ChildItem -Path $ApplicationFolder -Include "*.csv"

    $filelist | ForEach-Object { Import-CsvToStaging -CSVFileName $_.Name } 

    #$Message = "ApplicationName = $ApplicationName"
    #Log-ImportFramework $Message
}


function Log-ImportFramework {
    Param (
        [Parameter()]
            [string] $Message
    )

    $RootPath = $version["RootPath"]
    $LogFile = $version["LogFile"]

    If (!(Test-Path $version["LogFilePath"])) {
        New-Item -Path $version["LogFolder"] -Name $version["LogFile"] -ItemType "file" | Out-Null
    }

    $RunTime = Get-Date
    "$RunTime $Message" | Out-File -FilePath $version["LogFilePath"] -Append
}




