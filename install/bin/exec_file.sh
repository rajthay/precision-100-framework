#!/bin/bash

export CONTAINER=$1
SECONDS=0
LINE=$2
FILE_NAME=$(echo $LINE | cut -d ',' -f 2)
FILE_TYPE=$(echo $LINE | cut -d ',' -f 3)

$PRECISION100_FOLDER/bin/pre_file.sh $FILE_NAME $FILE_TYPE
echo "      START FILE $FILE_NAME";
case "$FILE_TYPE" in
  'sql')
    $PRECISION100_FOLDER/bin/sql_template.sh $CONTAINER $LINE
    ;;
  'loader')
   $PRECISION100_FOLDER/bin/loader_template.sh $CONTAINER $LINE
    ;;
  'sh')
    $PRECISION100_FOLDER/bin/shell_template.sh $CONTAINER $LINE
    ;;
  'spool')
    $PRECISION100_FOLDER/bin/spool_template.sh $CONTAINER $LINE
    ;;
esac
   
echo "      END FILE $FILE_NAME";
$PRECISION100_FOLDER/bin/post_file.sh $FILE_NAME $FILE_TYPE

echo "      Time taken to execute FILE $FILE_NAME: $SECONDS seconds"
