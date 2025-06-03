$diskPath = Read-Host "Ingrese la ruta del disco o carpeta a analizar"
Write-Host "El archivo más grande en $diskPath es:"
Get-ChildItem -Path $diskPath -Recurse -File | Sort-Object Length -Descending | Select-Object -First 1 | Format-Table FullName, Length
#El file es para que no muestre carpetas, solo archivos
# El comando Get-ChildItem obtiene los archivos y carpetas en la ruta especificada.
# El parámetro -Recurse permite buscar en subcarpetas.
# El comando Sort-Object ordena los archivos por tamaño (Length) en orden descendente.
# El comando Select-Object selecciona el primer archivo de la lista ordenada.
# El comando Format-Table formatea la salida para mostrar el nombre completo del archivo y su tamaño.