#!/bin/bash

#aquí ejecutaremos todos los ejercicios de la práctica 1, con un intervalo de tiempo de 10 segundos entre ejecuciones para analizar qué pasa en cada uno y diferenciarlos

tiempo=10
direccion=$HOME/UCLM_2025_2026/primer_cuatrimestre/sistemas_operativos/sesion_1_ssoo/

for archivo in "$direccion"/e*.sh; do

    chmod ugo+x "$archivo"

    bash "$archivo"

    echo ""
    echo "------------------------------------------------------------------------------------------------------------------------------------"
    echo "      Ha finalizado el ejercicio $(basename "$archivo"), espere $tiempo segundos para ejecutar el siguiente ejercicio."
    echo "------------------------------------------------------------------------------------------------------------------------------------"
    echo ""
    sleep $tiempo

done