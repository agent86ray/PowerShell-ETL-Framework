
# Version information
$version = @{
    Version = "1.1.0";
    ImportFolder = "IMPORT";
    LogFile = "LOG\ImportFramework.Log";
}


# SQL Server parameters
$sqlparameters = @{
    ServerInstance = "DESKTOP-CH7B7GJ\SQL2019DEV";
    DatabaseName = "staging";
    SchemaName="import";
    #Force=$true;
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
        Add-ImportFrameworkLog -Message "Application $ApplicationName created"
    }
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




