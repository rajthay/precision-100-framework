#!/bin/bash

PIPELINE=$1

if [[ -f $PIPELINE_FOLDER/$PIPELINE.txt ]]; then
   cat $PIPELINE_FOLDER/$PIPELINE.txt
else
  echo "File $PIPELINE_FOLDER/$PIPELINE.txt does not exist" 1>&2
fi
