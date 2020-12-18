# PSModulePath environment variable lists the folders where PowerShell
# looks for modules
$env:PSModulePath


<#
Returns for me:

C:\Users\raymo\OneDrive\Documents\WindowsPowerShell\Modules;C:\Program Files\Win
dowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Pro
gram Files (x86)\Microsoft SQL Server\150\Tools\PowerShell\Modules\


I put modules here:
C:\Program Files\WindowsPowerShell\Modules

#>

Get-Help Get-Module -Online


# show the modules imported into the current session
Get-Module


# show the modules available from the paths specified
# in the PSModulePath environment variable
Get-Module -ListAvailable


Get-Help Find-Module -Online

# Find "sql*" modules 
Find-Module "sql*"


Get-Help Install-Module -Online

# Install module


Get-Help Remove-Module -Online