echo "Listado de discos y espacio disponible:"
echo ""
printf "%-15s %-25s %-20s %-20s\n" "MontadoEn" "SistemaArchivos" "TamanoTotal(Bytes)" "EspacioLibre(Bytes)"
printf "%-15s %-25s %-20s %-20s\n" "-----------" "---------------" "--------------------" "--------------------"

# df -P: Formato POSIX, mas portable. Muestra en bloques de 1K por defecto.
# -B1 o --block-size=1: Para mostrar en bytes (especifico de GNU df).
# awk para procesar la salida:
#   NR>1 para saltar la cabecera de df.
#   $6: Punto de montaje (MontadoEn).
#   $1: Sistema de archivos (Fuente).
#   $2: Tamano total en bytes.
#   $4: Espacio disponible en bytes.
df -B1 --output=target,source,size,avail 2>/dev/null | awk 'NR>1 {printf "%-15s %-25s %-20s %-20s\n", $1, $2, $3, $4}'
