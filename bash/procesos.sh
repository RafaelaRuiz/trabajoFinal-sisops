echo "Los 5 procesos con mayor consumo de CPU:"
echo "" # Linea en blanco

echo "Top 5 procesos por uso de CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 