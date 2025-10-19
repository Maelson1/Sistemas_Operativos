#!/bin/bash

#Creamos las variables vacias para usarlas dentro de los bucles
profundidad=""
precision=""
bytes=""
directorios=()

#establecemos limites para las variables
profundidad_maxima=9
precision_maxima=2
max_bytes=2097152

#Definimos el tabulador para usarlo en la impresión por consola
TAB=$'\t'

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
                echo "${nombre}${TAB}(${tamano} bytes):" #imprimir su nombre y su tamaño
            fi
        fi
    done

    for elemento in "$dir"/*; do
        explorar "$elemento" $((nivel +1))
    done
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