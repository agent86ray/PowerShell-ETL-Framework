# create table

$csvfilepath = "C:\IMPORT\CUSTOMER-2\customer.csv"
$schemaname = "import"

$HeaderRow = Get-Content $csvfilepath |
    Select-Object -First 1
$ColumnNames = $HeaderRow -split ","

$filename = Split-Path -Path $csvfilepath -Leaf
$tablename = $filename.Split(".")[0]

Write-Output "CREATE TABLE [$schemaname].[$tablename] ( "

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
