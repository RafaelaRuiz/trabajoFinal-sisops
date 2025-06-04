$diskPath = Read-Host "Ingrese la ruta del disco o carpeta a analizar (ej: C:\Windows o D:\ )"

# Validar si la ruta existe
if (Test-Path $diskPath) {
    Write-Host "" # Línea en blanco para espaciar
    # El mensaje "El archivo más grande..." se mostrará después de la búsqueda si se encuentra algo.
    Write-Host "Buscando el archivo mas grande en '$diskPath'..."
    Write-Host "Esto podria tardar unos momentos..."

    $largestFile = Get-ChildItem -Path $diskPath -Recurse -File -ErrorAction SilentlyContinue | Sort-Object Length -Descending | Select-Object -First 1
    # El comando Get-ChildItem obtiene los archivos y carpetas en la ruta especificada.
    # El parámetro -Path especifica la ruta a buscar.
    # El parámetro -Recurse permite buscar en subcarpetas.
    # El parámetro -File asegura que solo se consideren archivos (no directorios).
    # El parámetro -ErrorAction SilentlyContinue suprime errores de acceso denegado o rutas no encontradas y permite que el script continúe.
    # El comando Sort-Object ordena los archivos por tamaño (Length) en orden descendente.
    # El comando Select-Object -First 1 selecciona el primer archivo de la lista ordenada (el más grande).

    if ($largestFile) {
        Write-Host "El archivo mas grande encontrado en '$diskPath' es:"
        # Mostrar FullName (ruta completa) y Length (tamaño en bytes)
        $largestFile | Format-Table FullName, @{Name="Tamaño (Bytes)"; Expression={$_.Length}}
    } else {
        Write-Host "No se encontraron archivos en la ruta '$diskPath' o no se pudo acceder a ninguno (posiblemente debido a errores o permisos en todas las subcarpetas)."
    }
} else {
    Write-Host "Error: La ruta '$diskPath' no existe o no es válida."
}