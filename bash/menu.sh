#!/bin/bash 

#Función para validar la opción ingresada por el usuario
validar_opcion(){
 	while [[ "$opcion" -lt 1 || "$opcion" -gt 6 ]]; do
 		echo "Opción invalida"
 		read -p "Opcion?" opcion
 	done
}

#Bucle principal del menú
while true; do
	echo "Menu de Administracion del Data Center"
    echo "1. Ver procesos que mas consumen CPU"
    echo "2. Ver discos conectados y espacio disponible"
    echo "3. Ver archivo mas grande en un disco"
    echo "4. Ver memoria libre y swap"
    echo "5. Ver conexiones de red activas"
    echo "6. Salir"
	read -p "Opción?: " opcion
	validar_opcion
	
	case $opcion in
		1) bash procesos.sh ;;
        2) bash discos.sh ;;
        3) bash archivo_grande.sh ;;
        4) bash memoria.sh ;;
        5) bash conexiones.sh ;;
        6) echo "Saliendo..."; exit ;;
	esac
done