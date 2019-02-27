#!/bin/bash

PIPELINE=$1

$PRECISION100_FOLDER/bin/pre_pipeline.sh $PIPELINE
echo "  START PIPELINE $PIPELINE"
if [ -f $PIPELINE_FOLDER/$PIPELINE.txt ]; then
   filelines=`cat $PIPELINE_FOLDER/$PIPELINE.txt`
   for line in $filelines ; do
       CONTAINER=$(echo $line | cut -d ',' -f 1)
       $PRECISION100_FOLDER/bin/exec_container.sh $CONTAINER
   done;
fi
echo "  END PIPELINE $PIPELINE"
$PRECISION100_FOLDER/bin/post_pipeline.sh $PIPELINE
