Write-Host "Informacion de memoria y swap:"

# Memoria Física Libre
# Win32_OperatingSystem.FreePhysicalMemory está en KB, así que se multiplica por 1KB (1024) para obtener bytes.
$freeMemoryBytes = (Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory * 1KB
Write-Host "Memoria fisica libre: $freeMemoryBytes bytes"

# Información del Espacio de Intercambio (Swap)
# Obtener la primera (usualmente única) entrada del archivo de paginación.
$pageFile = Get-CimInstance -ClassName Win32_PageFileUsage | Select-Object -First 1

if ($pageFile) {
    # Win32_PageFileUsage.CurrentUsage y .AllocatedBaseSize están en MB. Multiplicar por 1MB (1024*1024) para obtener bytes.
    $swapUsedBytes = $pageFile.CurrentUsage * 1MB
    $swapAllocatedBytes = $pageFile.AllocatedBaseSize * 1MB
    
    Write-Host "Espacio de swap en uso: $swapUsedBytes bytes"
    
    if ($swapAllocatedBytes -gt 0) {
        # Calcular y formatear el porcentaje directamente usando .ToString('P2') para dos decimales.
        # 'P2' usa la configuración cultural actual para el formato de porcentaje.
        $percentageInUse = $swapUsedBytes / $swapAllocatedBytes
        Write-Host "Porcentaje de swap en uso: $($percentageInUse.ToString('P2'))"
    } else {
        # Maneja casos donde un archivo de paginación podría existir pero tiene un tamaño asignado de 0.
        Write-Host "Porcentaje de swap en uso: N/A (Swap no configurado o tamano asignado cero)"
    }
} else {
    # Maneja casos donde no hay un archivo de paginación configurado o Get-CimInstance no devuelve objetos de archivo de paginación.
    Write-Host "Espacio de swap en uso: N/A (No se encontro archivo de paginacion configurado)"
    Write-Host "Porcentaje de swap en uso: N/A"
}