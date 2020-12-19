# pipeline


Get-Service | Select-Object -Property Name


# Show -Name parameter; Accept pipeline input=true (ByValue, ByPropertyName)
get-help Get-Service -Full


get-content -Path C:\IMPORT\TEXT\SERVICES.txt | Get-Member


get-content -Path C:\IMPORT\TEXT\SERVICES.txt | Get-Service


# TYPE" System.String
get-content -Path C:\IMPORT\TEXT\LIST.txt | Get-Member






get-help Import-Csv -Online



