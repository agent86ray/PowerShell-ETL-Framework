Get-Help Export-Csv -Online


# export services to a CSV file  
Get-Service | Export-Csv -Path C:\temp\service.csv


# By default the first line of the CSV file will have the
# "type" of the objects written to the file; e.g.
#
# #TYPE System.ServiceProcess.ServiceController	
#
# export services to a CSV file without #TYPE as first line 
Get-Service | Export-Csv -Path C:\temp\service.csv -NoTypeInformation


# "read" the csv file
Import-Csv -Path C:\temp\service.csv | Format-Table -AutoSize


