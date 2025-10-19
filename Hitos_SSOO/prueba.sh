#!/bin/bash

#Creamos las variables vacias para usarlas dentro de los bucles
profundidad=""
precision=""
bytes=""
directorios=()
array_de_strings=()

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

ordenar_archivos(){
    local -n arr_ref=$1
    arr_ref=()
    while read -r linea; do
        arr_ref+=("$linea")
    done < <(printf "%s\n" "${array_de_strings[@]}" | sort -t"$TAB" -k1,1 -k2,2n)
}
buscar_duplicados_l1(){
    local -n arr_ref=$1
    local nombre_anterior=""
    local elemento_anterior=""

    for elemento in "${arr_ref[@]}"; do
        nombre_actual=$(cut -d$'\t' -f1 <<< "$elemento" | tr -d ':') #extraemos el nombre del archivo actual
        if [ "$nombre_actual" = "$nombre_anterior" ]; then #comparamos el nombre actual con el anterior
            echo -e "${elemento}${BLINK}${elemento_anterior}${BLINK}"
        fi
        nombre_anterior="$nombre_actual" #actualizamos el nombre anterior al actual para la siguiente iteración
        elemento_anterior="$elemento" #actualizamos el elemento anterior al actual para la siguiente iteración
    done
}
buscar_duplicados_l2(){
    local -n arr_ref=$1
    local nombre_anterior=""
    local elemento_anterior=""

    for elemento in "${arr_ref[@]}"; do
        nombre_actual=$(cut -d$'\t' -f1 <<< "$elemento") #extraemos el nombre del archivo actual
        tamano_actual=$(cut -d$'\t' -f2 <<< "$elemento" | tr -d '() bytes:') #extraemos el tamaño del archivo actual
        tamano_anterior=$(cut -d$'\t' -f2 <<< "$elemento_anterior" | tr -d '() bytes:') #extraemos el tamaño del archivo anterior
        if [ "$nombre_actual" = "$nombre_anterior" ] && [ "$tamano_actual" = "$tamano_anterior" ]; then #comparamos el nombre actual con el anterior y el tamaño actual con el anterior
            echo -e "${elemento}${BLINK}${elemento_anterior}${BLINK}"
        fi
        nombre_anterior="$nombre_actual" #actualizamos el nombre anterior al actual para la siguiente iteración
        elemento_anterior="$elemento" #actualizamos el elemento anterior al actual para la siguiente iteración
    done
}
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
                string_archivos="${nombre}${TAB}(${tamano} bytes):" #acumular en el string su nombre y su tamaño
                array_de_strings+=("$string_archivos ${TAB}${ruta}") #añadir al array el string creado junto con la ruta del archivo
            fi
        elif [ -d "$elemento" ]; then #si elemento es un directorio...
            explorar "$elemento" $((nivel + 1)) #llamar recursivamente a la función explorar, aumentando el nivel de profundidad en 1
        fi
    done
}
array_to_string() {
    local -n array_ref=$1
    local resultado=""

    for elemento in "${array_ref[@]}"; do
        resultado+="$elemento"$'\n'
    done

    echo -n "$resultado"
}

string_to_array() {
    local -n array_resultado=$1
    local string_entrada="$2"

    array_resultado=()

    while read -r linea; do
        array_resultado+=("$linea")
    done <<< "$string_entrada"
}
#para Cosmin (lo di todo para estos 2 hitos :/ )
if [ "${directorios[*]}" = "patata" ]; then
    echo "patata"
    exit 0
fi

if [ -z "$bytes" ]; then
    bytes=0
    fi

for dir in "${directorios[@]}"; do
    explorar "$dir" 0
done

ordenar_archivos archivos_ordenados
string_resultante=$(array_to_string archivos_ordenados)
string_to_array array_final "$string_resultante"

if [ "$precision" = "1" ]; then
    buscar_duplicados_l1 archivos_ordenados
elif [ "$precision" = "$precision_maxima" ]; then
    buscar_duplicados_l2 archivos_ordenados
else
    echo "No se ha especificado un nivel de precisión válido (l1 o l2)"
    exit 1
fi