# ImportExcel module available on PowerShell Gallery
# https://www.powershellgallery.com/packages?q=importexcel
# The PowerShellGet module provides the lookup on the PowerShell Gallery
#
# YouTube videos: https://www.youtube.com/watch?v=U3Ne_yX4tYo&list=PL5uoqS92stXioZw-u-ze_NtvSo0k0K0kq
#
# Excel is NOT required to use this module to manipulate an Excel document.
#
Find-Module "ImportExcel"


# Install directly from the PowerShell Gallery
Install-Module -Name ImportExcel


# Details on ImportExcel module.  
# Returns TYPE: System.Management.Automation.PSModuleInfo 
Get-Module -Name ImportExcel | Get-Member


# Import if not in the session
Import-Module -Name ImportExcel


# quick and dirty pipe output to excel
# launches excel as temp file name
Get-Service | Export-Excel -Now


# export to excel file name
Get-Service | Export-Excel -Path C:\temp\services.xlsx -AutoSize -AutoFilter


# Read Excel and Export to CSV
Import-Excel -Path C:\temp\services.xlsx | Export-Csv -Path C:\temp\servicesfromexcel.csv

