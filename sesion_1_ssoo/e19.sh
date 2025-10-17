#!/bin/bash

cd ~/practicas/p3/


echo ""
echo "A continuación se abrirá un paginador less para ver el grupo de usuarios root:"
echo ""
sleep 2
less /etc/passwd
echo "A continuacion se abrirá un paginador less para ver el grupo de usuarios alumno:"
echo ""
sleep 2
less /etc/group
echo "El grupo de root es 0 mientras que el grupo de usuarios alumno es 100."
echo ""

sudo chmod g+x ~/alumno/practicas/p1
echo "Se ha concedido el permiso para ejecutar en p1."
echo ""

echo "A continuación se abrirá un paginador less para ver el contenido de p1.c:"
sleep 2
echo ""
less ~/practicas/p1/p1.c

echo "Se puede acceder porque el grupo del nodo tiene permiso de read (lectura) y el user alumno pertenece al grupo del nodo."
echo ""
