#!/bin/bash

if [[ -d "$DATAFLOW_FOLDER" ]]; then
 ls -1 $DATAFLOW_FOLDER | sed -e 's/\.txt$//'
else
 echo "Folder $DATAFLOW_FOLDER does not exist " 1>&2
fi
