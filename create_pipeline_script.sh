#!/bin/bash

PIPELINE=$1
PIPELINE_SCRIPT="$PIPELINE".sh
filelines=`cat $PIPELINE_FOLDER/$PIPELINE.txt`
for container in $filelines ; do
    $PRECISION100_FOLDER/create_container_script.sh $container
    echo "$CONTAINER_FOLDER/$container/container.sh" >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
done;
chmod u+x $PIPELINE_FOLDER/$PIPELINE_SCRIPT
