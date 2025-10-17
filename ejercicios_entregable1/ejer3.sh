#!/bin/bash

dir=$1

for elemento in "$dir"/*; do
    if [ -f "$elemento" ]; then
        name=$(basename "$elemento")
        tamano=$(stat -c%s "$elemento")
        ruta=$(realpath "$elemento")

        echo "Nombre: $name"
        echo "Tamaño: $tamano bytes"
        echo "Ruta: $ruta"
        echo "---"
    fi
done