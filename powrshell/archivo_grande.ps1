$diskPath = Read-Host "Ingrese la ruta del disco o carpeta a analizar"
Write-Host "El archivo más grande en $diskPath es:"
Get-ChildItem -Path $diskPath -Recurse | Sort-Object Length -Descending | Select-Object -First 1 | Format-Table FullName, Length
