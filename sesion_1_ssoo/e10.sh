#!/bin/bash

cd ~/practicas/p2

echo ""
echo "La cantidad de lineas es: "
ls -l -R -a ~/practicas/comun/ | wc -l #l es para el formato larog, a es para incluir achivos ocultos y R es para que se aplique de manera recursiva
# wc es contador de lineas, en este caso del listado y '|' es un pipe, conecta entrada y salida de 2 comandos.
echo ""