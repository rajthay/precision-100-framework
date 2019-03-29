#!/bin/bash

DATAFLOW=$1
if [[ -f $DATAFLOW_FOLDER/$DATAFLOW.txt ]]; then
   cat $DATAFLOW_FOLDER/$DATAFLOW.txt
else
  echo "File $DATAFLOW_FOLDER/$DATAFLOW.txt does not exist" 1>&2
fi
