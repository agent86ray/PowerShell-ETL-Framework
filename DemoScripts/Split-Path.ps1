# man is an alias for Get-Help
man Split-Path -online


$importfile = "C:\IMPORT\CRM\customer_20201217.csv"

# return folder name portion of path
$folder = Split-Path -Path $importfile
$folder


# return filename portion of path
$filename = Split-Path -Path $importfile -Leaf
$filename


# return filename portion of path without extension (PowerShell 6)
$filename = Split-Path -Path $importfile -LeafBase
$filename




# get the filename without the extension and up to
# not NOT including the '_' character

[int] $index = $filename.IndexOf("_")
$index

if ($index -eq -1) {
    $filename
}
else {
    $filename.Substring(0, $index)
}


$filename.Split("_")

$filename -split "-" | Get-Member



