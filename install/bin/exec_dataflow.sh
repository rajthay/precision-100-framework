#!/bin/bash

DATAFLOW=$1
SECONDS=0

$PRECISION100_FOLDER/bin/pre_dataflow.sh $DATAFLOW
echo "START DATAFLOW $DATAFLOW"
if [ -f $DATAFLOW_FOLDER/$DATAFLOW.txt ]; then
   filelines=`cat $DATAFLOW_FOLDER/$DATAFLOW.txt`
   for line in $filelines ; do
       PIPELINE=$(echo $line | cut -d ',' -f 1)
       $PRECISION100_FOLDER/bin/exec_pipeline.sh $PIPELINE
   done;
fi
echo "END DATAFLOW $DATAFLOW"

$PRECISION100_FOLDER/bin/post_dataflow.sh $DATAFLOW
echo "Time taken to execute DATAFLOW $DATAFLOW: $SECONDS seconds"
