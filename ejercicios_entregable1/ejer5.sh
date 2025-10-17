#!/bin/bash

profundidad_maxima=2

explorar(){
    local dir=$1
    local profundidad=$2

    if [ -z "$dir" ]; then
        echo "Por favor introduzca un valor válido para el directorio."
        exit 1
    elif ! [[ "$profundidad" =~ ^[0-9]+$ ]]; then
        echo "Por favor introduzca un valor válido para profundidad."
        exit 1
    fi

    if [ "$profundidad" -gt "$profundidad_maxima" ]; then
        return
    fi

    for elemento in "$dir"/*; do
        if [ -f "$elemento" ]; then
            nombre=$(basename "$elemento")
            echo "Nivel $profundidad: $nombre"
        fi
    done

    for elemento in "$dir"/*; do
        explorar "$elemento" $((profundidad + 1))
    done
}

carpeta=$1
explorar "$carpeta" 0