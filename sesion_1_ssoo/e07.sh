#!/bin/bash

cd ~/practicas/p2

ln ~/practicas/p3/p3.c ~/practicas/p1/p31.c

echo "Esta es la parte nueva." >> p31.c
echo ""
echo "Se abrirá el paginador less para p3.c, por favor, presionar q para cerrarlo."
echo ""
sleep 4 #esperamos 4 segundos para iniciar el less
less ~/practicas/p3/p3.c

sleep 4 #esperamos 4 segundos para ver que ha pasado

rm ~/practicas/p3/p3.c

echo "Se abrirá el paginador less para p31.c, por favor, presionar q para cerrarlo."
echo ""
less ~/practicas/p1/p31.c
less ~/practicas/p1/p31.c

echo "Lo que ha pasado es que se ha enlazado el archivo p3.c y el archivo p31.c, quiere decir que ambos archivos apuntan a exactamente el mismo espacio de memoria, sin ser una copia el uno del otro."
echo "Luego, se imprimió un mensaje de "Esta es la parte nueva." al final del archivo p31.c para posteriormente revisar el contenido con el paginador less para p3.c."
echo "Luego de ejecutar el paginador y ver el contenido, eliminamos el archivo p3.c para ver qué sucede."
echo "Abrimos el paginador para p31.c y revisamos el contenido para compararlo con el anterior."
echo "Lo que ha sucedido es que, como ambos apuntan a la misma dirección, a pesar de haber borrado p3.c y p31.c siguen apuntando a la misma dirección, por lo tanto se podrá contemplar lo mismo que antes incluyendo la línea añadida."
echo ""