#!/bin/bash

export CONTAINER=$1
SECONDS=0
LINE=$2
FILE_NAME=$(echo $LINE | cut -d ',' -f 2)
FILE_TYPE=$(echo $LINE | cut -d ',' -f 3)

$PRECISION100_FOLDER/bin/pre_file.sh $FILE_NAME $FILE_TYPE
echo "      START FILE $FILE_NAME";

declare -A operator_map

while IFS=$',\r' read key value;
do
   operator_map["$key"]="$value"
done < <(cat $PRECISION100_FOLDER/operators/*/operator.reg)

echo "        executing operator ${operator_map[$FILE_TYPE]} '$CONTAINER' '$LINE'"
if [ ${operator_map[$FILE_TYPE]+_} ]; then 
  EXEC_STRING="$PRECISION100_OPERATORS_FOLDER/${operator_map[$FILE_TYPE]}"
else 
  EXEC_STRING="$PRECISION100_OPERATORS_FOLDER/${operator_map['unknown-file-type']}"
fi
eval "${EXEC_STRING} '$CONTAINER' '$LINE'"
   
echo "      END FILE $FILE_NAME";
$PRECISION100_FOLDER/bin/post_file.sh $FILE_NAME $FILE_TYPE

echo "      Time taken to execute FILE $FILE_NAME: $SECONDS seconds"
