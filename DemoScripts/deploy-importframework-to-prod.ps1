# deploy ImportFramework module for prod


# show the module path
$env:PSModulePath


# copy module from dev to prod
$dev = "C:\repos\PowerShell-ETL-Framework\ImportFramework\ImportFramework.psm1"
$prod = "C:\Program Files\WindowsPowerShell\Modules\ImportFramework"

if (!(test-path $prod)) {
    New-Item $prod -ItemType "Directory"
}

Copy-Item -Path $dev -Destination $prod


