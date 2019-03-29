#!/bin/bash

CONTAINER=$1
SECONDS=0

$PRECISION100_FOLDER/bin/pre_container.sh $CONTAINER

echo "    START CONTAINER $CONTAINER";
filelines=$($PRECISION100_FOLDER/bin/get-files.sh $CONTAINER)
for line in $filelines ; do
  filename=$(echo $line | cut -d ',' -f 2)
  filetype=$(echo $line | cut -d ',' -f 3)
  
  $PRECISION100_FOLDER/bin/exec_file.sh $CONTAINER $line
done;
echo "    END CONTAINER $CONTAINER";

$PRECISION100_FOLDER/bin/post_container.sh $CONTAINER
echo "    Time taken to execute CONTAINER $CONTAINER: $SECONDS seconds"
