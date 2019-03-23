#!/bin/bash

export CONTAINER=$1
SECONDS=0
LINE=$2
FILE_NAME=$(echo $LINE | cut -d ',' -f 2)
FILE_TYPE=$(echo $LINE | cut -d ',' -f 3)

$PRECISION100_FOLDER/bin/pre_file.sh $FILE_NAME $FILE_TYPE
echo "      START FILE $FILE_NAME";

declare -A operator_map
operator_map['sql']='$PRECISION100_FOLDER/bin/sql_template.sh'
operator_map['loader']='$PRECISION100_FOLDER/bin/loader_template.sh'
operator_map['sh']='$PRECISION100_FOLDER/bin/sh_template.sh'
operator_map['spool']='$PRECISION100_FOLDER/bin/spool_template.sh'
operator_map['smartloader']='$PRECISION100_FOLDER/bin/smart-loader-template.sh'
operator_map['map-file']='$PRECISION100_FOLDER/bin/map-file-template.sh'
operator_map['length-validator']='$PRECISION100_FOLDER/bin/length-validator-template.sh'

if [ ${operator_map[$FILE_TYPE]+_} ]; then 
  eval ${operator_map[$FILE_TYPE]} $CONTAINER $LINE
else 
  echo $PRECISION100_FOLDER/bin/${operator_map[$FILE_TYPE]} $CONTAINER $LINE
fi
#case "$FILE_TYPE" in
  #'sql')
    #$PRECISION100_FOLDER/bin/sql_template.sh $CONTAINER $LINE
    #;;
  #'loader')
   #$PRECISION100_FOLDER/bin/loader_template.sh $CONTAINER $LINE
    #;;
  #'sh')
    #$PRECISION100_FOLDER/bin/shell_template.sh $CONTAINER $LINE
    #;;
  #'spool')
    #$PRECISION100_FOLDER/bin/spool_template.sh $CONTAINER $LINE
    #;;
  #'smartloader')
    #$PRECISION100_FOLDER/bin/smart-loader-template.sh $CONTAINER $LINE
    #;;
  #'map-file')
    #$PRECISION100_FOLDER/bin/map-file-template.sh $CONTAINER $LINE
    #;;
  #'length-validator')
    #$PRECISION100_FOLDER/bin/length-validator-template.sh $CONTAINER $LINE
    #;;
#esac
   
echo "      END FILE $FILE_NAME";
$PRECISION100_FOLDER/bin/post_file.sh $FILE_NAME $FILE_TYPE

echo "      Time taken to execute FILE $FILE_NAME: $SECONDS seconds"
