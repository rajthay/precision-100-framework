#!/bin/bash

CONTAINER=$1

if [[ -f $CONTAINER_FOLDER/$CONTAINER/file.txt ]]; then
   cat $CONTAINER_FOLDER/$CONTAINER/file.txt
else
  echo "File $CONTAINER_FOLDER/$CONTAIER/file.txt does not exist" 1>&2
fi
