while ($true) {
    Write-Host "Menu de Administracion del Data Center"
    Write-Host "1. Ver procesos que mas consumen CPU"
    Write-Host "2. Ver discos conectados y espacio disponible"
    Write-Host "3. Ver archivo mas grande en un disco"
    Write-Host "4. Ver memoria libre y swap"
    Write-Host "5. Ver conexiones de red activas"
    Write-Host "6. Salir"
    $opcion = Read-Host "Seleccione una opcion"

    switch ($opcion) {
        1 { .\procesos.ps1 }
        2 { .\discos.ps1 }
        3 { .\archivo_grande.ps1 }
        4 { .\memoria.ps1 }
        5 { .\conexiones.ps1 }
        6 { Write-Host "Saliendo..."; exit }
        default { Write-Host "Opcion invalida. Intente de nuevo." }
    }
}
