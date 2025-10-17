#!/bin/bash

"archivo1.txt"
"archivo1.txt"
"archivo2.txt"
"archivo3.txt"
"archivo3.txt"
"archivo3.txt"
"archivo4.txt"

nombre_anterior=""
contador_duplicados=0
duplicados_encontrados=false

for nombre_actual in "${nombres_ordenados[@]}"; do
    if [ "$nombre_actual" = "$nombre_anterior" ]; then
        echo "Duplicado encontrado: $nombre_actual"
        contador_duplicados=$((contador_duplicados + 1))
        duplicados_encontrados=true
    fi
    nombre_anterior="$nombre_actual"
done
if [ $duplicados_encontrados = true ]; then
    echo "Total de duplicados encontrados: $contador_duplicados"
else 
    echo "No se encontraron archivos duplicados."
fi