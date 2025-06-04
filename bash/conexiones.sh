#!/bin/bash
# Archivo: /trabajoFinal-sisops/bash/conexiones.sh
# Muestra el numero de conexiones de red activas (ESTABLISHED).

echo "Numero de conexiones de red activas:"

# ss es el comando moderno, netstat es el antiguo.
# -H: no mostrar cabecera (para ss)
# -t: tcp
# -n: numerico
# state established: filtrar por estado (para ss)
# grep 'ESTABLISHED': filtrar por estado (para netstat)
# wc -l: contar lineas
if command -v ss &> /dev/null; then
    count=$(ss -Htn state established | wc -l)
elif command -v netstat &> /dev/null; then
    count=$(netstat -ant | grep 'ESTABLISHED' | wc -l)
else
    count="N/A (ss y netstat no encontrados)"
fi
echo "$count"
