# Proyecto Final de Sistemas Operativos - Herramientas de Administración de Data Center

Integrantes: 

**Jennifer Castro**

**Rafaela Ruiz**

Este proyecto consiste en dos herramientas de línea de comandos, una desarrollada en PowerShell y otra en Bash, diseñadas para facilitar tareas comunes de administración de sistemas en un data center. Ambas herramientas presentan un menú interactivo para acceder a sus funcionalidades.

## Presentación del Proyecto

El objetivo es proveer a los administradores de sistemas un conjunto de scripts simples y efectivos para monitorear y obtener información clave del sistema operativo de manera rápida, tanto en entornos Windows (con PowerShell) como en entornos Linux/Unix (con Bash).

## Funcionalidades Implementadas

Ambas versiones (PowerShell y Bash) ofrecen las siguientes opciones a través de un menú:

1.  **Ver procesos que más consumen CPU:** Despliega los cinco procesos que están utilizando más recursos de CPU en el momento.
2.  **Ver discos conectados y espacio disponible:** Muestra los sistemas de archivos o discos, su tamaño total y el espacio libre en bytes.
3.  **Ver archivo más grande en un disco:** Solicita una ruta y encuentra el archivo de mayor tamaño dentro de ella, mostrando su nombre completo, trayectoria y tamaño en bytes.
4.  **Ver memoria libre y swap:** Informa sobre la cantidad de memoria física libre y el uso del espacio de intercambio (swap), tanto en bytes como en porcentaje.
5.  **Ver conexiones de red activas:** Indica el número de conexiones de red que se encuentran actualmente en estado `ESTABLISHED`.

## Documentación Técnica

A continuación, se detallan los comandos y conceptos clave utilizados en cada entorno:

### PowerShell

Los scripts de PowerShell (`.ps1`) se encuentran en el directorio `powershell/`.

* **Menú Principal (`menu.ps1`):**
    * Uso de bucle `while ($true)` para mantener el menú activo.
    * `Read-Host` para la entrada del usuario.
    * Estructura `switch` para manejar las opciones.
    * Llamada a otros scripts: `.\nombre_script.ps1`.
    * `Clear-Host` para limpiar la pantalla.
    * `$OutputEncoding = [System.Text.Encoding]::UTF8` y `[Console]::OutputEncoding = [System.Text.Encoding]::UTF8` para intentar mejorar la visualización de caracteres especiales.

* **Procesos (`procesos.ps1`):**
    * `Get-Process`: Obtiene la lista de procesos.
    * `Sort-Object CPU -Descending`: Ordena los procesos por uso de CPU.
    * `Select-Object -First 5`: Selecciona los 5 primeros.
    * `Format-Table ProcessName, Id, CPU`: Formatea la salida en una tabla.

* **Discos (`discos.ps1`):**
    * `Get-Volume`: Obtiene información sobre los volúmenes de almacenamiento.
    * `Select-Object DriveLetter, FileSystemLabel, @{Name="TamanoTotal (Bytes)"; Expression={$_.Size}}, @{Name="EspacioLibre (Bytes)"; Expression={$_.SizeRemaining}}`: Selecciona y renombra propiedades para la salida.
    * `Format-Table`: Formatea la salida.

* **Archivo Más Grande (`archivo_grande.ps1`):**
    * `Read-Host`: Para solicitar la ruta al usuario.
    * `Test-Path`: Verifica si una ruta existe.
    * `Get-ChildItem -Path $diskPath -Recurse -File -ErrorAction SilentlyContinue`: Obtiene todos los archivos recursivamente en la ruta, ignorando errores de acceso o rutas no encontradas.
    * `Sort-Object Length -Descending`: Ordena los archivos por tamaño.
    * `Select-Object -First 1`: Selecciona el archivo más grande.
    * `Format-Table FullName, @{Name="Tamano (Bytes)"; Expression={$_.Length}}`: Muestra la ruta completa y el tamaño.

* **Memoria y Swap (`memoria.ps1`):**
    * `Get-CimInstance -ClassName Win32_OperatingSystem`: Para obtener `FreePhysicalMemory`.
    * `Get-CimInstance -ClassName Win32_PageFileUsage`: Para obtener información del archivo de paginación (swap) como `CurrentUsage` y `AllocatedBaseSize`.
    * Cálculos para convertir a bytes y obtener porcentajes.
    * `.ToString('P2')` para formatear porcentajes.

* **Conexiones (`conexiones.ps1`):**
    * `Get-NetTCPConnection`: Obtiene información de las conexiones TCP.
    * `Where-Object {$_.State -eq "Established"}`: Filtra las conexiones en estado "ESTABLISHED".
    * `.Count`: Cuenta el número de conexiones filtradas.

### Bash

Los scripts de Bash (`.sh`) se encuentran en el directorio `bash/`.

* **Menú Principal (`menu.sh`):**
    * Uso de bucle `while true` para el menú.
    * `read -p "..." opcion` para la entrada del usuario.
    * Estructura `case $opcion in ... esac` para manejar las opciones.
    * Llamada a otros scripts: `bash ./nombre_script.sh`.
    * `clear` para limpiar la pantalla.
    * Función `pausa_continuar` con `read -p "Presione Enter..."`.

* **Procesos (`procesos.sh`):**
    * `ps -eo comm:30,pid,pcpu --no-headers --sort=-pcpu`: Muestra el nombre del comando (limitado a 30 caracteres), PID y %CPU, sin cabeceras, ordenado por %CPU.
    * `head -n 5`: Selecciona los 5 primeros.
    * `awk '{printf ...}'`: Para formatear la salida en columnas alineadas.

* **Discos (`discos.sh`):**
    * `df -B1 --output=target,source,size,avail`: Muestra información de los sistemas de archivos con tamaño en bytes y campos específicos (Punto de montaje, Dispositivo, Tamaño total, Disponible). La opción `--output` es de GNU `df`.
    * `awk 'NR>1 {printf ...}'`: Para saltar la cabecera de `df` y formatear la salida.

* **Archivo Más Grande (`archivo_grande.sh`):**
    * `read -p "..." search_path`: Solicita la ruta.
    * `[ ! -d "$search_path" ]`: Verifica si el directorio existe.
    * `find "$search_path" -type f -printf "%p\t%s\n" 2>/dev/null`: Encuentra todos los archivos, imprime ruta completa y tamaño en bytes, separándolos con un tabulador. Los errores se redirigen a `/dev/null`.
    * `sort -nrk2`: Ordena por la segunda columna (tamaño) numéricamente en reversa.
    * `head -n 1`: Selecciona el más grande.
    * `IFS=$'\t' read -r full_path size_bytes <<< "$largest_file_info"`: Divide la línea resultante en variables.
    * `printf`: Para formatear la salida.

* **Memoria y Swap (`memoria.sh`):**
    * `grep "^MemAvailable:" /proc/meminfo | awk '{print $2}'`: Obtiene la memoria disponible en KB de `/proc/meminfo`. Se convierte a bytes.
    * `grep "^SwapTotal:" /proc/meminfo` y `grep "^SwapFree:" /proc/meminfo`: Obtienen el total y libre del swap en KB.
    * Cálculos en Bash (`$((...))`) para obtener el swap usado en bytes.
    * `awk "BEGIN {printf \"%.2f\", ...}"`: Para calcular y formatear el porcentaje de swap usado.
    * `printf`: Para mostrar la información formateada.

* **Conexiones (`conexiones.sh`):**
    * `ss -Htn state established | wc -l`: Usa `ss` (herramienta moderna) para listar conexiones TCP establecidas y cuenta las líneas.
    * `netstat -ant | grep 'ESTABLISHED' | wc -l`: Alternativa con `netstat` si `ss` no está disponible.

## Cómo Ejecutar el Proyecto

1.  **Clonar el Repositorio:**
    Abrir una terminal o consola y clona el repositorio en tu máquina local:
    ```bash
    git clone `https://github.com/RafaelaRuiz/trabajoFinal-sisops.git`
    cd trabajoFinal-sisops/
    ```

2.  **Ejecutar la Herramienta PowerShell (en Windows):**
    * Abre PowerShell.
    * Navegar al directorio del proyecto y luego a la carpeta `powershell`:

    * Ejecuta el script del menú:
        ```powershell
        .\menu.ps1
        ```

3.  **Ejecutar la Herramienta Bash (en Linux/WSL/macOS):**
    * Abre tu terminal Bash.
    * Navegar al directorio del proyecto y luego a la carpeta `bash`:
      
    * Otorgar permisos de ejecución a los scripts `.sh` :
        ```bash
        chmod +x *.sh
        ```
    * Ejecuta el script del menú:
        ```bash
        ./menu.sh
        ```
