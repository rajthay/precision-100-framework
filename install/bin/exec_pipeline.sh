#!/bin/bash

PIPELINE=$1

if [ -f $PIPELINE_FOLDER/$PIPELINE.txt ]; then
   filelines=`cat $PIPELINE_FOLDER/$PIPELINE.txt`
   for line in $filelines ; do
       CONTAINER=$(echo $line | cut -d ',' -f 1)
       $PRECISION100_FOLDER/bin/exec_container.sh $CONTAINER
   done;
fi
