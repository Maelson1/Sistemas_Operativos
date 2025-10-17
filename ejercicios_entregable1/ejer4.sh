#!/bin/bash

dir=$1
nombrearr=()

if [ -z "$dir" ]; then
    echo ""
    echo "No se ha pasado ningún parametro para directorio, por favor ingrese uno."
    exit 1
elif [ ! -d "$dir" ]; then
    echo "El parámetro seleccionado para 'directorio' no es válido."
    exit 1
fi

for elemento in "$dir"/*; do
    if [ -f "$elemento" ]; then
        nombre=$(basename "$elemento")
        nombrearr+=("$nombre")
    fi
done

echo ""
echo "Archivos encontrados: "
echo ""
for elemento in "${nombrearr[@]}"; do
    if [ -z "$elemento" ]; then
        echo "No se han encontrado archivos dentro del directorio."
    else
        echo "- $elemento"
    fi
done
echo ""