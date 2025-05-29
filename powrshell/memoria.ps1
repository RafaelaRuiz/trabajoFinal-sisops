Write-Host "Información de memoria y swap:"
Get-ComputerInfo | Select-Object CsFreePhysicalMemory, CsTotalPhysicalMemory
