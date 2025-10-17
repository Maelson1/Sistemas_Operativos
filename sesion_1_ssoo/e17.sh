#!/bin/bash

cd ~/practicas/p3

echo ""
ls -l ~/practicas/p1/p2/README.txt
echo ""
echo "El administrador sólo tiene permiso de lectura"
echo ""
sleep 1
echo "Se cambiarán los permisos de README.txt utilizando el modo absoluto."
echo ""
sleep 2
chmod 666 ~/practicas/p1/p2/README.txt
echo "Cambio exitoso, todos los usuarios pueden escribir en README.txt"
echo ""
sleep 1
echo "Se cambiarán los permisos de README.txt utilizando el modo simbólico."
echo ""
sleep 2
chmod ugo=r ~/practicas/p1/p2/README.txt
echo "Cambio exitoso, cualquie usuario puede leer en README.txt"
echo ""