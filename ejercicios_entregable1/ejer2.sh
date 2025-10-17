#!/bin/bash

dir=$1

for elemento in "$dir"/*; do
    if [ -f "$elemento" ]; then
        echo "$elemento es un archivo."
    else
        echo " $elemento es un directorio."
    fi
done