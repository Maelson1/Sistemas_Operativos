#!/bin/bash

dir=$1
TAB=$'\t'
registros=()

for archivo in "$dir"/*; do
        if [ -f "$archivo" ]; then
            nombre=$(basename "$archivo")
            tamano=$(stat -c%s "$archivo")
            ruta=$(realpath "$archivo")

            registro="${nombre}${TAB}${tamano}${TAB}${ruta}"

            registros+={"$registro"}
        fi
done

for registro in "${registros[@]}"; do
        echo "$registro"
done