#!/bin/bash

TABLE_NAME_PREFIX=${DEFAULT_TABLE_NAME_PREFIX:-O}
FILE_NAME_SUFFIX=${DEFAULT_FILE_NAME_SUFFIX:-csv}
COLUMN_NAME_INDEX=${DEFAULT_COLUMN_NAME_INDEX:-1}
DATA_TYPE_INDEX=${DEFAULT_DATA_TYPE_INDEX:-2}
MAX_LENGTH_INDEX=${DEFAULT_MAX_LENGTH_INDEX:-5}
MAP_FILE_DELIMITER=${DEFAULT_MAP_FILE_DELIMITER:-~}

TABLE_NAME=$1
SOURCE_FILE=$2

echo "DELETE FROM O_TAB_COLUMNS WHERE TABLE_NAME =  UPPER('${TABLE_NAME_PREFIX}_${TABLE_NAME}');"

counter=0
while IFS=$MAP_FILE_DELIMITER read -r column_name data_type max_length mapping_code mapping_value;
do
  column_name=$(echo $line | cut -d "$DELIMITER" -f $COLUMN_NAME_INDEX)
  data_type=$(echo $line | cut -d "$DELIMITER" -f $DATA_TYPE_INDEX)
  max_length=$(echo $line | cut -d "$DELIMITER" -f $MAX_LENGTH_INDEX)
  if [[ counter -eq 0 ]]; then
    counter=$counter+1;
    continue;
  fi
  if [[ -z $max_length ]]; then
     max_length=0
  fi
  echo "INSERT INTO O_TAB_COLUMNS ( TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_LENGTH ) VALUES ( UPPER('${TABLE_NAME_PREFIX}_${TABLE_NAME}'), UPPER('$column_name'), UPPER('$data_type'), $max_length);"
done < "${SOURCE_FILE}"
