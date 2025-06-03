Write-Host "Listado de discos y espacio disponible:"
Get-Volume | Select-Object DriveLetter, FileSystemLabel, @{Name="TamañoTotal (Bytes)"; Expression={$_.Size}}, @{Name="EspacioLibre (Bytes)"; Expression={$_.SizeRemaining}} | Format-Table
# El comando Get-Volume obtiene información sobre los volúmenes de disco.
# El comando Select-Object selecciona las propiedades que queremos mostrar: letra de unidad, etiqueta del sistema de archivos, tamaño total y espacio libre.
# El comando Format-Table formatea la salida en una tabla para una mejor visualización.
#  @{Name="TamañoTotal (Bytes)"; Expression={$_.Size}} y @{Name="EspacioLibre (Bytes)"; Expression={$_.SizeRemaining}} son objetos calculados que permiten mostrar el tamaño total y el espacio libre en bytes.
# El @ es un operador que permite crear un objeto calculado con un nombre y una expresión.