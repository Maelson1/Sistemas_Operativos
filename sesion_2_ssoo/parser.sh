#!/bin/bash

opcionA=0

espera_argumento=""

for arg in "$@"; do
	echo "Valor de arg= $arg"
	if [ -n "$espera_argumento" ]; then
		echo "Opcion $espera_argumento con arg; $arg"
		espera_argumento=""
		opcionA=$arg
		continue
	fi

	case "$arg" in
		-A)
			espera_argumento="-A"
			;;
		*)
			echo "Opción adicional $arg"
			;;
	esac
done

echo "$opcionA"
