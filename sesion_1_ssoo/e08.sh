#!/bin/bash

cd ~/practicas/p2

#-s es para declarar que es un enlace simbólico
ln -s ~/practicas/comun/comun.c ~/practicas/p1/lcomun.c
ln -s ~/practicas/comun/comun.h ~/practicas/p1/lcomun.h

#-l muestra los archivos y directorios en formato largo para ls
echo ""
ls -l ~/practicas/p1/

echo ""
echo "Se abrirá el paginador para el archivo lcomun.c, presionar q para salir."
sleep 2
less ~/practicas/p1/lcomun.c

echo ""
sleep 1.5
rm ~/practicas/comun/comun.c
echo "Se ha eliminado el archivo comun.c."
echo ""


echo "Se abrirá el paginador para el archivo lcomun.c, presionar q para salir."
sleep 2
echo ""
less ~/practicas/p1/lcomun.c

echo ""
echo "Creamos 2 enlaces simbólicos para los archivos comun.c y comun.h, pero los generaremos en p1 en vez de crearlo en el home o en su directorio de origen."
echo "Imprimimos por pantalla los directorios de p1 para comprobar el resultado del directorio p1"
echo "Mediante el comando less, abrimos un paginador para explorar el contenido del nuevo archivo lcomun.c y lo imprime"
echo "Borramos el archivo comun.c y luego intentamos abrir mediante el comando less."
echo "Aquí comprobamos que no se puede abrir, arroja un error debido a que borramos el archivo original, y la raíz del problema es que ambos apuntan a la misma dirección pero siendo un enlace simbólico, pero ya se borró la dirección del disco al eliminar el otro archivo."
echo ""