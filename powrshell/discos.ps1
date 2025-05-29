Write-Host "Listado de discos y espacio disponible:"
Get-PSDrive | Where-Object { $_.Provider -eq "FileSystem" }
