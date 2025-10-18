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
echo ""

bucle_principal(){
for elemento in "${directorios[@]}"; do #busca elementos dentro del array directorios
    if [ -d "$elemento" ]; then #si el elemento es un directorio, haz lo siguiente:
        for archivo in "$elemento"/*; do #para cada archivo dentro del directorio(elemento),
            if [ -f "$archivo" ]; then #si es un archivo, entonces:
                nombre=$(basename "$archivo") #asignas nombre
                ruta=$(realpath "$archivo") #asignas la ruta
                tamano=$(stat -c%s "$archivo") #asignas el tamaño
                echo -e "${nombre}${TAB}${ruta}${TAB}${tamano} bytes" #imprimes el nombre, la ruta y el tamaño
            fi
        done
    else #si el elemento dentro del array no es un directorio o no existe, imprimes un error
        echo "La ruta $elemento no es un directorio válido o no existe."
        exit 1
    fi
done | sort -t$'\t' -k1,1 #conectas la salida del bucle con el comando sort para ordenarlos alfabéticamente
}

#Vamos a establecer una serie de controles antes de que el programa pueda ejecutarse de manera correcta

#control para profundidad
if [ -n "$profundidad" ] && ! [[ "$profundidad" =~ ^[0-9]+$ ]]; then
    echo "Lo siento, introduzca un valor válido para profundidad (-p) en el próximo intento."
    exit 1
fi

#control para precision
if [ -n "$precision" ] && ! [[ "$precision" =~ ^[0-9]+$ ]]; then
    echo "Lo siento, introduzca un valor válido para precisión (-l) en el próximo intento."
    exit 1
fi

#control para bytes
if [ -n "$bytes" ] && ! [[ "$bytes" =~ ^[0-9]+$ ]]; then
    echo "Lo siento, introduzca un valor válido para bytes (-s) en el próximo intento."
    exit 1
fi

#control para rutas
if [ -z "${directorios[*]}" ]; then
    directorios=("./")
    echo "No se ha detectado ninguna ruta, se usará la ruta actual por defecto."
    echo ""
    bucle_principal
    exit 0
fi
bucle_principal
exit 0