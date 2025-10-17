#!/bin/bash

#esta vez no voy a introducir el comando cd ~ ya que vamos a suponer que estamos en home

mkdir ~/work/

ln -s /var/log/packages/bison-2.4.3-i486-2 ~/work/bison.log
echo ""
echo "Se ha creado el directorio work y el enlace simbólico correctamente."
echo ""
ls -l ~/work/
echo ""