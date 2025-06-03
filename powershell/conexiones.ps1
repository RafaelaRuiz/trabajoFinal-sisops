Write-Host "Número de conexiones de red activas:"
(Get-NetTCPConnection | Where-Object {$_.State -eq "Established"}).Count

# Get-NetTCPConnection obtiene las conexiones TCP.
# Where-Object {$_.State -eq "Established"} filtra para obtener solo las conexiones en estado "Established".
# .Count cuenta el número de conexiones que cumplen con el filtro.
