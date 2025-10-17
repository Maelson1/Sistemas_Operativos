#!/bin/bash

cd ~/practicas/p3

sudo chown root /home/alumno/practicas/p1
sudo chmod go-x /home/alumno/practicas/p1

echo ""
echo "Se ha cambiado el propietario de p1 y se ha retirado los permisos de ejecución con éxito."
echo ""
echo "Se abrirá el paginador con less, presionar q para salir:"
sleep 2
echo ""

less ~/practicas/p1/p1.c
sleep 5

echo "No se ha podido leer el archivo, no tenemos permiso de ejecución en un subdirectorio de acceso al archivo."
echo ""