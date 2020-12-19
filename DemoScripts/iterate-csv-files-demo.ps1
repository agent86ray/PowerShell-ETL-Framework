# iterate thru CSV files in a folder structure

ForEach(
    $csvfilepath in Get-Childitem -Path C:\IMPORT -Recurse *.csv | 
    Select-Object -Expand FullName) {

    $filename = Split-Path -Path $csvfilepath -Leaf
    $tablename = $filename.Split(".")[0]

    Import-CsvToStaging -CSVFilePath $filename -TableName $tablename
}

