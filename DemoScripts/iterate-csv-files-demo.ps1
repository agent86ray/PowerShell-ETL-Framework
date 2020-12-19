# iterate thru CSV files in a folder structure

ForEach(
    $csvfilepath in get-childitem -path C:\IMPORT -recurse *.csv | 
    select-object -expand FullName) {

        $filename = Split-Path -Path $csvfilepath -Leaf
        $tablename = $filename.Split(".")[0]

    "Import CSVFilePath=$csvfilepath Table Name=$tablename"
}

