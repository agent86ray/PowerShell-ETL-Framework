# man is an alias for Get-Help
man Split-Path -online


# return folder name portion of path
$folder = Split-Path -Path "C:\IMPORT\CRM\customer_20201217.csv"
$folder


# return filename portion of path
$filename = Split-Path -Path "C:\IMPORT\CRM\customer_20201217.csv" -Leaf
$filename



