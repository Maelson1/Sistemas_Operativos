#!/bin/bash
cd ~ #aseguramos de ubicarnos en home

mkdir ~/practicas #creamos el directorio practicas dentro del home
mkdir ~/practicas/backup #creamos el directorio backup (vacio)
mkdir ~/practicas/comun #creamos el directorio comun

#files .h y .c (en este caso txt con el nombre) para comun
touch ~/practicas/comun/comun.c ~/practicas/comun/comun.h

#iniciamos un for para crear los directorios y archivos designados en el diagrama (en este caso, solo se tomara 1, 2 y 3)
for i in 1 2 3; do
    mkdir ~/practicas/p$i
    touch ~/practicas/p$i/Makefile$i ~/practicas/p$i/p$i.c ~/practicas/p$i/p$i.h

done #cerramos el for

touch ~/practicas/p2/README.txt #añadimos el README.txt que solo lo tiene el directorio p2, si fuese otro el caso también incluiríamos en el bucle

for dir in ~/practicas/*; do #iniciamos un bucle para recorrer directorios dentro del archivo practicas para luego acceder a ellos
    if [ -d "$dir" ]; then #iniciamos un condicionante 'if', que tiene la funcion de comprobar si la variable dir es un directorio
        cd "$dir" #entramos en el directorio actual recorrido
        for archivo in *; do #inciamos otro bucle for para que busque la variable archivo dentro del wildcard (llama a todos los archivvos dentro del directorio)
            if [ -f "$archivo" ]; then #iniciamos un condicional 'if' para que identifique si la variable archivo es realmente un archivo
                echo "Este es el archivo $archivo." > "$archivo" #si se cunple la condicion, imprimimos el mensaje dentro del archivo
            fi #procedemos a cerrar todos los bucles abiertos
        done
    fi
done
echo ""
echo "Se ha creado el directorio practicas dentro de home."
echo ""
ls ~
echo ""
cd ~/practicas
ls -R
echo ""
#fin del codigo