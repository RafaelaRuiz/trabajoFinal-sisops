Write-Host "Número de conexiones de red activas:"
(Get-NetTCPConnection | Where-Object {$_.State -eq "Established"}).Count
