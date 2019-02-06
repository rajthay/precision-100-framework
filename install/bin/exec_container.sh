#!/bin/bash

CONTAINER=$1

if [ -f $CONTAINER_FOLDER/$CONTAINER/file.txt ]; then
   filelines=`cat $CONTAINER_FOLDER/$CONTAINER/file.txt`
   for line in $filelines ; do
       filename=$(echo $line | cut -d ',' -f 2)
       filetype=$(echo $line | cut -d ',' -f 3)
       $PRECISION100_FOLDER/exec_file.sh $CONTAINER $filename $filetype
   done;
fi
