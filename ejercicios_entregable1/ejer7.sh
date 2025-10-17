#!/bin/bash

array_to_string(){
    local -n array_ref=$1
    local resultado=""

    for elemento in "${array_ref[@]}"; do
        resultado+="$elemento"$'\n'
    done

    echo -n "$resultado"
}

string_to_array(){
    local -n array_result=$1
    local string_entry="$2"

    array_result=()

    local total_lineas=$(wc -l <<< "$string_entry")

    for (( i=1; i<total_lineas; i++ )); do
        linea=$(cut -d $'\n' -f "$i" <<< "$string_entry")
        array_result+=("$linea")
    done
}
#Ejemplo
mi_array=("linea1" "linea2" "linea3")
mi_string=$(array_to_string mi_array)
echo "String resultante:"
echo "$mi_string"

nuevo_array=()
string_to_array nuevo_array "$mi_string"
echo "Array resultante:"
for elemento in "${nuevo_array[@]}"; do
    echo "- $elemento"
done