#!/bin/bash

CONTAINER=$1

if [[ -f $CONTAINER_FOLDER/$CONTAINER/container.reg ]]; then
   cat $CONTAINER_FOLDER/$CONTAINER/container.reg
else
  if [[ -f $CONTAINER_FOLDER/$CONTAINER/file.txt ]]; then
     cat $CONTAINER_FOLDER/$CONTAINER/file.txt
     echo "Template still uses file.txt - please move to container.reg as early as possible." 1>&2
     echo "Templates using file.txt will not be supported in the future." 1>&2
  else
    echo "Registry file in $CONTAINER_FOLDER/$CONTAINER does not exist" 1>&2
  fi
fi
