#!/bin/bash

TAB=$'\t'
registros_string="documento.txt${TAB}500${TAB}/home/user/documentol.txt
archivo.pdf${TAB}1200${TAB}/home/user/archivo.pdf
backup.zip${TAB}3000${TAB}/home/user/backup.zip
archivo.pdf${TAB}800${TAB}/tmp/archivo.pdf
documento.txt${TAB}500${TAB}/backup/documento.txt"
echo "=== Sin ordenar ==="
echo "$registros_string"
echo ""
echo "=== Ordenado por noombre (campo 1) ==="
string_ordenado=$(sort -t$'\t' -k1,1 <<< "$registros_string")
echo "$string_ordenado"