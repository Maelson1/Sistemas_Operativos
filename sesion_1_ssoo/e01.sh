#!/bin/bash
#a
echo ""
pwd
echo ""
cd ~
cat /etc/passwd
#b
cat /etc/passwd > /tmp/usuarios
#c
cd /tmp
cat /etc/passwd > ~/usuarios
#d
cat /etc/group >> ~/usuarios
#e
cat /etc/shells /etc/services > varios
#f
sleep 4
echo ""
echo "Se ejecutará un cat, en caso de querer finalizar el cat pulse ctrl + D."

cat

#finalizar manualmente ctrl + D