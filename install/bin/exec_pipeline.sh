#!/bin/bash

PIPELINE=$1
SECONDS=0

$PRECISION100_FOLDER/bin/pre_pipeline.sh $PIPELINE
echo "  START PIPELINE $PIPELINE"
filelines=$($PRECISION100_FOLDER/bin/get-containers.sh $PIPELINE)
for line in $filelines ; do
  CONTAINER=$(echo $line | cut -d ',' -f 1)
  $PRECISION100_FOLDER/bin/exec_container.sh $CONTAINER
done;
echo "  END PIPELINE $PIPELINE"
$PRECISION100_FOLDER/bin/post_pipeline.sh $PIPELINE

echo "  Time taken to execute PIPELINE $PIPELINE: $SECONDS seconds"
