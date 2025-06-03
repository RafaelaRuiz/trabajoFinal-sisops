Write-Host "Los 5 procesos con mayor consumo de CPU:"
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Format-Table ProcessName, Id, CPU
# Get-Process obtiene la lista de procesos en ejecución.
# Sort-Object CPU -Descending ordena los procesos por el valor de la propiedad CPU en orden descendente.
# Select-Object -First 5 selecciona los primeros 5 procesos de la lista ordenada.
# Format-Table muestra las propiedades seleccionadas (ProcessName, Id, CPU) en un formato de tabla.
