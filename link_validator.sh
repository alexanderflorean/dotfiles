#!/bin/bash

# first argument takes in the source file, second is the link to the source file

source_file = $1
target_file = $2

if [ ! \( -e "${target_file}" \) ]
then
     echo "%ERROR: The target file ${target_file} does not exist!" >&2
     exit 1
elif [ ! \( -f "${target_file}" \) ]
then
     echo "%ERROR: ${target_file} is not a file!" >&2
     exit 2
fi

