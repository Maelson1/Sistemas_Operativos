#!/bin/bash

#Creamos las variables vacias para usarlas dentro de los bucles
profundidad=""
precision=""
bytes=""
directorios=()
array_de_string=()

#establecemos limites para las variables
profundidad_maxima=9
precision_maxima=2
max_bytes=2097152

#Definimos el tabulador para usarlo en la impresión por consola
TAB=$'\t'
BLINK=$'\n'

parseo_variables(){ #Iniciamos un bucle while, el cual parseará los argumentos introducidos mediante la ejecución 
while [ $# -gt 0 ]; do #El bucle leerá la cantidad de argumentos introducidos mediante $# y lo comparará con -gt (mayor que) 0, esto quiere decir que cuando la variable sea 0, el bucle se detiene
    recursiva="$1" #copia el argumento actual para guardarlo en case
    case "$recursiva" in 
        -p)
            profundidad="$2" #primera variable a procesar, las siguientes irán usandose de manera recursiva
            shift 2 #corremos a la izquierda 2 variables para no precesar la misma 
            ;;
        -l)
            precision="$2" 
            shift 2
            ;;
        -s)
            bytes="$2"
            shift 2
            ;;
        *)
            directorios+=("$1")
            shift
            ;;
    esac
done
}

parseo_variables "$@"

explorar(){
    local dir=$1 #declaramos una variable local para que lea los directorios del array
    local nivel=$2 #declaramos que existe un nivel de profundidad
    local limite_profundidad #declaramos un limite de profundidad, que será definido a gusto del usuario

    if [ -n "$profundidad" ]; then #si la variable profundidad no está vacía es porque el usuario la asignó, y se usará esa para el método
        limite_profundidad=$profundidad
    else #si no está vacía, se usará la máxima como límite
        limite_profundidad=$profundidad_maxima
    fi

    if [ "$nivel" -ge "$limite_profundidad" ]; then #si el nivel actual de profundidad iguala o supera el limite (contando desde 0), el bucle se detiene
        return
    fi

    for elemento in "$dir"/*; do #para cada elemento dentro de un directorio,...
        if [ -f "$elemento" ]; then #si elemento es un archivo...
            nombre=$(basename "$elemento") #declarar nombre mediante basename al elemento (archivo)
            tamano=$(stat -c%s "$elemento") #declarar tamaño mediante -c%s al elemento (archivo)
            ruta=$(realpath "$elemento")
            if [ "$tamano" -ge "$bytes" ] && [ "$tamano" -le "$max_bytes" ]; then #si el tamaño (bytes) cumple con los limites establecidos
                string_archivos_desordenado="${nombre}${TAB}(${tamano} bytes)${BLINK}${ruta}${BLINK}" #almacenar nombre y tamaño en archivo
                string_archivos_ordenados=$(sort -t$'\t' -k1,1 <<< "$string_archivos_desordenado")
                array_de_string+=("$string_archivos_ordenados")
            fi
        fi
    done

    for elemento in "$dir"/*; do
        explorar "$elemento" $((nivel +1))
    done
}

array_to_string(){
    local -n array_ref=$1
    local resultado=""

    for elemento in "${array_ref[@]}"; do
    resultado+="$elemento"$'\n'
    done
    
    echo -n "$resultado"
}

string_to_array_l1(){
    local -n array_result=$1
    local string_entry=$2
    local total_lineas
    total_lineas=$(wc -l <<< "$string_entry")

    array_result=()

    for (( i=1; i<total_lineas; i++)); do
        linea=$(cut -d $'\n' -f "$i" <<< "$string_entry")
        if [[ "$linea" == *"$bytes"* ]]; then
            nombre=$(cut -f1 <<< "$linea")
            array_result+=("$nombre")
        fi
    done

    echo "${array_result[@]}"
}

string_to_array_l2(){
    local -n array_result=$1
    local string_entry=$2
    local total_lineas

    total_lineas=$(wc -l <<< "$string_entry")
    array_result=()

    for (( i=1; i<total_lineas; i++)); do
        linea=$(cut -d $'\n' -f "$i" <<< "$string_entry")
        if [[ "$linea" == *"$bytes"* ]]; then
            nombre=$(cut -f1 <<< "$linea")
            array_result+=("${linea}")
        fi
    done

    echo "${array_result[@]}"
}

#para Cosmin
if [ "${directorios[*]}" = "patata" ]; then
    echo "patata"
    exit 0
fi

if [ -z "$bytes" ]; then
    echo "No se ha especificado el tamaño mínimo"
    exit 1
    fi

if [ -z "${directorios[*]}" ]; then
    directorios=(./)
    echo ""
    echo "Se ejecutará en el directorio actual:"
    echo ""
fi

for dir in "${directorios[@]}"; do
    explorar "$dir" 0
done

mi_string=$(array_to_string array_de_string)
echo "$mi_string"

if [ "$precision" -gt "$precision_maxima" ]; then
    echo "Ha superado el nivel de precision máxima"
elif [ "$precision" -eq 1 ]; then
        nuevo_array=()
    string_to_array_l1 nuevo_array "$mi_string"
    for elemento in "${nuevo_array[@]}"; do
        echo "$elemento"
    done
elif [ "$precision" -eq 2 ]; then
    nuevo_array=()
    string_to_array_l2 nuevo_array "$mi_string"
    for elemento in "${nuevo_array[@]}"; do
        echo "$elemento"
    done
else
    echo "Valor no válido para -l (precision), por favor asigne un valor entre 1 y 2"
fi