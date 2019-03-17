#!/bin/bash

TABLE_NAME_PREFIX=${DEFAULT_TABLE_NAME_PREFIX:-O}
COLUMN_NAME_INDEX=${DEFAULT_COLUMN_NAME_INDEX:-1}
DATA_TYPE_INDEX=${DEFAULT_DATA_TYPE_INDEX:-2}
MAX_LENGTH_INDEX=${DEFAULT_MAX_LENGTH_INDEX:-4}
MAPPING_TYPE_INDEX=${DEFAULT_MAPPING_TYPE_INDEX:-7}
MAPPING_VALUE_INDEX=${DEFAULT_MAPPING_VALUE_INDEX:-8}

TABLE_NAME=$1
SOURCE_FILE=$2
echo "INSERT INTO ${TABLE_NAME_PREFIX}_${TABLE_NAME} ("
counter=0
while IFS=$'\r' read -r -a line
do
  column_name=$(echo $line | cut -d',' -f $COLUMN_NAME_INDEX)
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
echo ") SELECT "

counter=0
while IFS=$'\r' read -r -a line
do
  column_name=$(echo $line | cut -d',' -f $COLUMN_NAME_INDEX)
  mapping_type=$(echo $line | cut -d',' -f $MAPPING_TYPE_INDEX)
  mapping_value=$(echo $line | cut -d',' -f $MAPPING_VALUE_INDEX)

  if [[ counter -eq 0 ]]; then
    counter=$counter+1;
    continue;
  fi

  echo " -- $column_name"
  case "$mapping_type" in
   'CONSTANT')
     column="'$mapping_value'"
    ;;
   'PASSTHRU')
     column="$mapping_value"
    ;;
   *)
     column="'$column_name'"
    ;;
  esac

  if [[ counter -eq 1 ]]; then
    echo "  $column"
  else
    echo ", $column"
  fi
  counter=$counter+1;
done < "${SOURCE_FILE}"
echo "FROM DUAL;"
