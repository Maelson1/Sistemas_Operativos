#!/bin/bash

dir=$1

for elemento in "$dir"/*; do
    echo "$elemento"
done