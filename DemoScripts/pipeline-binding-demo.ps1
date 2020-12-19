# pipeline binding demo
#
# get the list of CSV files in a folder 
# insert the contents of each CSV file into a SQL Server table


get-help get-childitem -full # show -Path parameter


# get the list of csv files in a folder; file name property is Name 
get-childitem -path C:\IMPORT\CRM *.csv


# get the TypeName that get-childitem returns: System.IO.FileInfo
get-childitem -path C:\IMPORT\CRM *.csv | get-member


# -expand returns a TypeName Syste.String
get-childitem -path C:\IMPORT\CRM *.csv |  
    select-object -expand FullName | get-member


# 
get-help import-csv -full


# get the full path of the CSV files as a string
$csvfiles = get-childitem -path C:\IMPORT\CRM *.csv |  
    select-object -expand FullName 


$csvfiles = get-childitem -path C:\IMPORT\CRM *.csv |  
    sort-object -Property LastWriteTimeUtc |
    select-object -expand FullName
$csvfiles.Count



ForEach(
    $csvfilepath in get-childitem -path C:\IMPORT -recurse *.csv | 
    select-object -expand FullName) {

        $filename = Split-Path -Path $csvfilepath -Leaf
        $tablename = $filename.Split(".")[0]

    "Import CSVFilePath=$csvfilepath Table Name=$tablename"

<#
    $filename

    $tablename = $filename.Split(".")[0]
    $tablename


    #$tablename
#>
}


$filestoimport = @()
$filestoimport.count

get-help foreach-object -online


$csvfiles | Get-Member


$csvfiles | foreach-object { Import-CsvToStaging -$CSVFileName $_.FullName }
     
$csvfiles | Import-Csv


# -Path position=0, accept pipeline input=true (ByValue, ByPropertyName)
# Returns 2 rows






Get-Service | Select-Object -Property Name


# Show -Name parameter; Accept pipeline input=true (ByValue, ByPropertyName)
get-help Get-Service -Full


get-content -Path C:\IMPORT\TEXT\SERVICES.txt | Get-Member


get-content -Path C:\IMPORT\TEXT\SERVICES.txt | Get-Service


# TYPE" System.String
get-content -Path C:\IMPORT\TEXT\LIST.txt | Get-Member






get-help Import-Csv -Full



