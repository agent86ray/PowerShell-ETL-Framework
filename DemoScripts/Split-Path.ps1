# man is an alias for Get-Help
man Split-Path -online


$importfile = "C:\IMPORT\CRM\customer_20201217.csv"

# return folder name portion of path
$folder = Split-Path -Path $importfile
$folder


# return filename portion of path
$filename = Split-Path -Path $importfile -Leaf
$filename


# split filename on "_"




