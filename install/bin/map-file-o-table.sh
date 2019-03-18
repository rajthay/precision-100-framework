#!/bin/bash

TABLE_NAME_PREFIX=${DEFAULT_TABLE_NAME_PREFIX:-O}
FILE_NAME_SUFFIX=${DEFAULT_FILE_NAME_SUFFIX:-csv}
COLUMN_DATA_TYPE=${DEFAULT_COLUMN_DATA_TYPE:-NVARCHAR2(2000)}
COLUMN_NAME_INDEX=${DEFAULT_COLUMN_NAME_INDEX:-1}
DATA_TYPE_INDEX=${DEFAULT_DATA_TYPE_INDEX:-2}
MAX_LENGTH_INDEX=${DEFAULT_MAX_LENGTH_INDEX:-5}

VALIDATION_TABLE_NAME_PREFIX=${DEFAULT_VALIDATION_TABLE_NAME_PREFIX:-V}
VALIDATION_TABLE_NAME_SUFFIX=${DEFAULT_VALIDATION_TABLE_NAME_SUFFIX:-SRY}

TABLE_NAME=$1
SOURCE_FILE=$2
echo "DROP TABLE ${TABLE_NAME_PREFIX}_${TABLE_NAME};"
echo "CREATE TABLE ${TABLE_NAME_PREFIX}_${TABLE_NAME} ("
counter=0
while read line
do
  column_name=$(echo $line | cut -d',' -f $COLUMN_NAME_INDEX)
  data_type=$(echo $line | cut -d',' -f $DATA_TYPE_INDEX)
  max_length=$(echo $line | cut -d',' -f $MAX_LENGTH_INDEX)
  if [[ counter -eq 0 ]]; then
    counter=$counter+1;
    continue;
  fi
  if [[ counter -eq 1 ]]; then
    counter=$counter+1;
    echo "  $column_name $COLUMN_DATA_TYPE"
    continue;
  fi
  counter=$counter+1;
  echo ", $column_name $COLUMN_DATA_TYPE"
done < "${SOURCE_FILE}"
echo ");"
echo "CREATE TABLE ${VALIDATION_TABLE_NAME_PREFIX}_${TABLE_NAME}_${VALIDATION_TABLE_NAME_SUFFIX} ( VALIDATION_NAME, RECORD_COUNT );"
