#!/bin/bash

#Creamos las variables vacias para usarlas dentro de los bucles
profundidad=""
precision=""
bytes=""
directorios=()

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

#Vamos a establecer una serie de controles antes de que el programa pueda ejecutarse de manera correcta

#control para profundidad
if ! [[ "$profundidad" =~ ^[0-9]+$ ]]; then
    echo "Lo siento, introduzca un valor válido para profundidad (-p) en el próximo intento."
    exit 1
fi
