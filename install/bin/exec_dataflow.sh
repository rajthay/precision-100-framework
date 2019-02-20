#!/bin/bash

DATAFLOW=$1

if [ -f $DATAFLOW_FOLDER/$DATAFLOW.txt ]; then
   filelines=`cat $DATAFLOW_FOLDER/$DATAFLOW.txt`
   for line in $filelines ; do
       PIPELINE=$(echo $line | cut -d ',' -f 1)
       $PRECISION100_FOLDER/bin/exec_pipeline.sh $PIPELINE
   done;
fi
