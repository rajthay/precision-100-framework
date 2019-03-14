#!/bin/bash

PIPELINE=$1

PRE_PIPELINE_TIME=($($PRECISION100_FOLDER/bin/pre_pipeline.sh $PIPELINE))
echo "  START PIPELINE $PIPELINE"
if [ -f $PIPELINE_FOLDER/$PIPELINE.txt ]; then
   filelines=`cat $PIPELINE_FOLDER/$PIPELINE.txt`
   for line in $filelines ; do
       CONTAINER=$(echo $line | cut -d ',' -f 1)
       $PRECISION100_FOLDER/bin/exec_container.sh $CONTAINER
   done;
fi
echo "  END PIPELINE $PIPELINE"
POST_PIPELINE_TIME=($($PRECISION100_FOLDER/bin/post_pipeline.sh $PIPELINE))


timediff=$(( (${POST_PIPELINE_TIME[4]} - ${PRE_PIPELINE_TIME[4]}) / 1000 ))
echo "  Time taken to execute PIPELINE $PIPELINE: $timediff seconds"
