#!/bin/bash

CONTAINER=$1

if [[ -f $CONTAINER_FOLDER/$CONTAINER/container.reg ]]; then
   cat $CONTAINER_FOLDER/$CONTAINER/container.reg
else
  if [[ -f $CONTAINER_FOLDER/$CONTAINER/file.txt ]]; then
     cat $CONTAINER_FOLDER/$CONTAINER/file.txt
  else
    echo "Registry file in $CONTAINER_FOLDER/$CONTAINER does not exist" 1>&2
  fi
fi
