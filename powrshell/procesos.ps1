Write-Host "Los 5 procesos con mayor consumo de CPU:"
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
