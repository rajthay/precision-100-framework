#!/bin/bash

TABLE_NAME_PREFIX=${DEFAULT_TABLE_NAME_PREFIX:-O}
FILE_NAME_SUFFIX=${DEFAULT_FILE_NAME_SUFFIX:-csv}
COLUMN_NAME_INDEX=${DEFAULT_COLUMN_NAME_INDEX:-1}
DATA_TYPE_INDEX=${DEFAULT_DATA_TYPE_INDEX:-2}
MAX_LENGTH_INDEX=${DEFAULT_MAX_LENGTH_INDEX:-5}

TABLE_NAME=$1
SOURCE_FILE=$2
echo "INSERT INTO ${TABLE_NAME_PREFIX}_${TABLE_NAME} ("
counter=0
while read line
do
  column_name=$(echo $line | cut -d',' -f1)
  data_type=$(echo $line | cut -d',' -f2)
  max_length=$(echo $line | cut -d',' -f5)
  if [[ counter -eq 0 ]]; then
    counter=$counter+1;
    continue;
  fi
  if [[ counter -eq 1 ]]; then
    counter=$counter+1;
    echo "  $column_name"
    continue;
  fi
  counter=$counter+1;
  echo ", $column_name"
done < "${SOURCE_FILE}"
echo ") VALUES ("

counter=0
while read line
do
  column_name=$(echo $line | cut -d',' -f $COLUMN_NAME_INDEX)
  if [[ counter -eq 0 ]]; then
    counter=$counter+1;
    continue;
  fi
  echo " -- $column_name"
  if [[ counter -eq 1 ]]; then
    counter=$counter+1;
    echo "'  $column_name'"
    continue;
  fi
  counter=$counter+1;
  echo ", '$column_name'"
done < "${SOURCE_FILE}"
echo ");"
