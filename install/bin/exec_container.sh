#!/bin/bash

CONTAINER=$1

PRE_CONTAINER_TIME=($($PRECISION100_FOLDER/bin/pre_container.sh $CONTAINER))

echo "    START CONTAINER $CONTAINER";
if [ -f $CONTAINER_FOLDER/$CONTAINER/file.txt ]; then
   filelines=`cat $CONTAINER_FOLDER/$CONTAINER/file.txt`
   for line in $filelines ; do
       filename=$(echo $line | cut -d ',' -f 2)
       filetype=$(echo $line | cut -d ',' -f 3)
       $PRECISION100_FOLDER/bin/exec_file.sh $CONTAINER $filename $filetype
   done;
fi
echo "    END CONTAINER $CONTAINER";

POST_CONTAINER_TIME=($($PRECISION100_FOLDER/bin/post_container.sh $CONTAINER))

timediff=$(( (${POST_CONTAINER_TIME[4]} - ${PRE_CONTAINER_TIME[4]}) / 1000 ))
echo "Time taken to execute CONTAINER $CONTAINER: $timediff seconds"
