echo "Informacion de memoria y swap:"

# Memoria Fisica Libre (en bytes)
# MemAvailable de /proc/meminfo es la mejor metrica para memoria realmente disponible.
mem_available_kb=$(grep "^MemAvailable:" /proc/meminfo | awk '{print $2}')
if [ -n "$mem_available_kb" ]; then
    printf "Memoria fisica libre            : %s bytes\n" "$((mem_available_kb * 1024))"
else
    mem_free_kb=$(grep "^MemFree:" /proc/meminfo | awk '{print $2}')
    printf "Memoria fisica libre (MemFree)  : %s bytes\n" "$((mem_free_kb * 1024))"
fi

# Informacion del Espacio de Intercambio (Swap)
swap_total_kb=$(grep "^SwapTotal:" /proc/meminfo | awk '{print $2}')
swap_free_kb=$(grep "^SwapFree:" /proc/meminfo | awk '{print $2}')

if [ -z "$swap_total_kb" ]; then
    printf "Espacio de swap en uso          : N/A (No se encontro SwapTotal)\n"
    printf "Porcentaje de swap en uso       : N/A\n"
elif [ "$swap_total_kb" -eq 0 ]; then
    printf "Espacio de swap en uso          : 0 bytes\n"
    printf "Porcentaje de swap en uso       : N/A (Swap no configurado)\n"
else
    swap_used_kb=$((swap_total_kb - swap_free_kb))
    swap_used_bytes=$((swap_used_kb * 1024))
    printf "Espacio de swap en uso          : %s bytes\n" "$swap_used_bytes"
    
    swap_percentage_used=$(awk "BEGIN {if ($swap_total_kb > 0) printf \"%.2f\", ($swap_used_kb / $swap_total_kb) * 100; else print \"0.00\";}")
    printf "Porcentaje de swap en uso       : %s %%\n" "$swap_percentage_used" # Agregado el simbolo %
fi