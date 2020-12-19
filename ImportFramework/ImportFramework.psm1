
# Version information
$version = @{
    Version = "1.1.0";
    ImportFolder = "IMPORT";
    ArchiveFolder = "ARCHIVE";
    LogFile = "LOG\ImportFramework.Log";
}


# SQL Server parameters
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "staging";
    SchemaName="import";
    #not working on my underpowered SQL 2019 instance
    #Force=$true;
}


function Get-ImportFrameworkConfiguration {

    $version
    $sqlparameters
}


function Create-TableScriptFromCsv {

    Param (
        [Parameter()]
            [string] $CSVFilePath
    )

    $DatabaseName = $sqlparameters.DatabaseName
    $SchemaName = $sqlparameters.SchemaName

    $HeaderRow = Get-Content $csvfilepath |
        Select-Object -First 1
    $ColumnNames = $HeaderRow -split ","

    $filename = Split-Path -Path $csvfilepath -Leaf
    $tablename = $filename.Split(".")[0]

    Write-Output "CREATE TABLE [$DatabaseName].[$SchemaName].[$tablename] ( "

    [int] $ColumnNumber = 0
    $Comma = ", "

    ForEach($ColumnName in $ColumnNames) {
        if ($ColumnNumber -eq 0) {
            Write-Output "   [$ColumnName] VARCHAR(255)"
        }
        else {
            Write-Output "$Comma [$ColumnName] VARCHAR(255)"
        }
        
        $ColumnNumber += 1
    }

    Write-Output ");"

}


function Move-CsvToArchive {

    Param (
        [Parameter()]
            [string] $CSVFilePath
        ,
        [Parameter()]
            [string] $TableName
    )

    $csvfilename = Split-Path -Path $CSVFilePath -Leaf
    [string] $timestamp = (Get-Date).ToFileTimeUtc()
    $filenameplustimestamp = $TableName + "_" + $timestamp
    $archivefilename = $csvfilename -replace $TableName, $filenameplustimestamp
    $archivefoldername = (Split-Path -Path $csvfilepath) -replace $version.ImportFolder, $version.ArchiveFolder
    $archivefilepath = Join-Path $archivefoldername $archivefilename

    Move-Item -Path $CSVFilePath -Destination $archivefilepath
}


function Import-CsvToStaging {

    Param (
        [Parameter()]
            [string] $CSVFilePath
        ,
        [Parameter()]
            [string] $TableName
    )

    Import-Csv -Path $CSVFilePath |
        Write-SqlTableData -TableName $TableName @sqlparameters 

    Move-CsvToArchive -CSVFilePath $CSVFilePath -TableName $TableName
}


function Import-CsvCustomerFile {

    Param (
        [Parameter()]
            [string] $RootFolder
    )

    $CustomerPath = Join-Path $RootFolder $version.ImportFolder

    ForEach (
        $csvfilepath in Get-Childitem -Path $CustomerPath *.csv | 
        Select-Object -Expand FullName) {

        $filename = Split-Path -Path $csvfilepath -Leaf
        $tablename = $filename.Split(".")[0]

        Import-CsvToStaging -CSVFilePath $csvfilepath -TableName $tablename
    }

}


function Add-ImportFrameworkLog {
    Param (
        [Parameter()]
            [string] $LogFilePath
        ,
        [Parameter()]
            [string] $Message
    )

    $RootPath = $version["RootPath"]
    $LogFile = $version["LogFile"]

    If (!(Test-Path $LogFilePath)) {
        New-Item -Path $LogFilePath -Name $version["LogFile"] -ItemType "file" | Out-Null
    }

    $RunTime = Get-Date
    "$RunTime $Message" | Out-File -FilePath $version["LogFilePath"] -Append
}




