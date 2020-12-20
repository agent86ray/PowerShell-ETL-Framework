
Get-Help New-Item -Online


# top-level folder name
$RootFolder = "C:\BSSUG\CUSTOMER-2"


# create top-level folder if it doesn't exist
if (!(Test-Path $RootFolder)) {
    New-Item -Path $RootFolder -ItemType "Directory"
}


# list of subfolders to create
$folders = "IMPORT", "ARCHIVE", "LOG"


# create any subfolders that do not exist
ForEach ($folder in $folders) {

    $subfolder = Join-Path $RootFolder $folder
    if (!(Test-Path $subfolder)) {
        New-Item -Path $RootFolder -Name $folder -ItemType "Directory"
    }
}




