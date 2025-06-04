 read -rp "Ingrese el path del disco o carpeta (por ejemplo /home): " ruta
if [ -d "$ruta" ]; then
    echo ""
    echo "Buscando el archivo más grande en $ruta ..."
    archivo=$(find "$ruta" -type f -printf "%s %p\n" 2>/dev/null | sort -nr | head -n 1)
    if [ -n "$archivo" ]; then
        tamano=$(echo "$archivo" | cut -d' ' -f1)
        ruta_completa=$(echo "$archivo" | cut -d' ' -f2-)
        echo "Archivo más grande encontrado:"
        echo "Ruta: $ruta_completa"
        echo "Tamaño: $tamano bytes"
    else
        echo "No se encontraron archivos en la ruta especificada."
    fi
else
    echo "Ruta inválida. Intente nuevamente."
fi
