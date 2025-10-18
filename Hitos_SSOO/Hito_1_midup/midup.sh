#!/bin/bash

#Creamos las variables vacias para usarlas dentro de los bucles
profundidad=""
precision=""
bytes=""
directorios=()

#Definimos el tabulador para usarlo en la impresión por consola
TAB=$'\t'

bucle_recursivo(){ #Iniciamos un bucle while, el cual parseará los argumentos introducidos mediante la ejecución 
while [ $# -gt 0 ]; do #El bucle leerá la cantidad de argumentos introducidos mediante $# y lo comparará con -gt (mayor que) 0, esto quiere decir que cuando la variable sea 0, el bucle se detiene
    recursiva="$1"
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

bucle_recursivo "$@"

#Imprimimos por consola los datos de las variables introducidas
echo "Nivel de profundidad: $profundidad"
echo "Nivel de precisión: $precision"
echo "Tamaño mínimo en bytes: $bytes"
echo "Rutas a procesar: ${directorios[*]}"

for dir in "${directorios[@]}"; do
    if [ -d "$dir"]; then
        for archivo in "$dir"/*; do
            if [ -f "$archivo" ]; then
                nombre=$(basename "$archivo")
                ruta=$(realpath "$archivo")
                tamano=$(stat -c%s "$archivo")
                echo -e "${nombre}${TAB}${ruta}${TAB}${tamano} bytes"
            fi
        done
    else
        echo "La ruta $dir no es un directorio válido."
    fi
done | sort -t$'\t' -k1,1

#Vamos a establecer una serie de controles antes de que el programa pueda ejecutarse de manera correcta

#control para profundidad
if [ -n "$profundidad" ] &&! [[ "$profundidad" =~ ^[0-9]+$ ]]; then
    echo "Lo siento, introduzca un valor válido para profundidad (-p) en el próximo intento."
    exit 1
fi

#control para precision
if [ -n "$precision" ] &&! [[ "$precision" =~ ^[0-9]+$ ]]; then
    echo "Lo siento, introduzca un valor válido para profundidad (-p) en el próximo intento."
    exit 1
fi

#control para bytes
if [ -n "$bytes" ] &&! [[ "$bytes" =~ ^[0-9]+$ ]]; then
    echo "Lo siento, introduzca un valor válido para bytes (-s) en el próximo intento."
    exit 1
fi
#control para rutas
if [${directorios[@]} -eq 0]; then
    then $directorios=("./")
    echo "No se ha detectado ninguna ruta, se usará la ruta actual por defecto."
fi