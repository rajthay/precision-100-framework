#!/bin/bash

CONTAINER=$1
INDEX=$(echo $2 | cut -d ',' -f 1)
FILE_NAME=$(echo $2 | cut -d ',' -f 2)

echo "        START MAP-FILE ADAPTOR $FILE_NAME"

if test "$SIMULATION_MODE" = "TRUE"; then
   sleep $SIMULATION_SLEEP;
   echo "        END MAP-FILE ADAPTOR $FILE_NAME"
   exit;
fi

source $PRECISION100_FOLDER/conf/.map-file.env.sh
mkdir -p $MAP_FILE_WORK_FOLDER;

SOURCE_FILE="$CONTAINER_FOLDER/$CONTAINER/$FILE_NAME.$MAP_FILE_FILE_SUFFIX"
DDL_SOURCE_FILE="$MAP_FILE_WORK_FOLDER/$FILE_NAME.$MAP_FILE_FILE_SUFFIX.ddl"
JOIN_SOURCE_FILE="$MAP_FILE_WORK_FOLDER/$FILE_NAME.$MAP_FILE_FILE_SUFFIX.join"
MAP_FILE_DELIMITER=${DEFAULT_MAP_FILE_DELIMITER:-~}

grep -i -v ${MAP_FILE_JOIN_FILTER} $SOURCE_FILE > "$DDL_SOURCE_FILE"
grep ${MAP_FILE_JOIN_FILTER} $SOURCE_FILE |  tr -d "$MAP_FILE_DELIMTER" |  sed -n "s/${MAP_FILE_JOIN_FILTER}//p" > "$JOIN_SOURCE_FILE"

O_TABLE_SQL=$MAP_FILE_WORK_FOLDER/"${DEFAULT_TABLE_NAME_PREFIX}-${FILE_NAME}.sql"
O_TAB_COLUMN_SQL=$MAP_FILE_WORK_FOLDER/"${DEFAULT_TABLE_NAME_PREFIX}-${FILE_NAME}-${DEFAULT_TAB_COLUMN_SUFFIX}.sql"
TRANSFORM_SQL=$MAP_FILE_WORK_FOLDER/"${DEFAULT_TABLE_NAME_PREFIX}-${FILE_NAME}-${DEFAULT_TRANSFORM_SUFFIX}.sql"

$PRECISION100_FOLDER/bin/audit.sh  $0 "PRE-MAP-FILE" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "MAP-FILE" $0 "START"

echo "        MAP-FILE ADAPTOR CREATING O_ TABLE SCRIPT"
$PRECISION100_OPERATORS_FOLDER/map-file/bin/map-file-o-table.sh $FILE_NAME $DDL_SOURCE_FILE > $O_TABLE_SQL

echo "        MAP-FILE ADAPTOR CREATING INSERT TABLE METADATA SCRIPT"
$PRECISION100_OPERATORS_FOLDER/map-file/bin/map-file-tab-columns.sh $FILE_NAME $DDL_SOURCE_FILE > $O_TAB_COLUMN_SQL

echo "        MAP-FILE ADAPTOR CREATING TRANSFORM SCRIPT"
$PRECISION100_OPERATORS_FOLDER/map-file/bin/map-file-transform.sh $FILE_NAME $DDL_SOURCE_FILE $JOIN_SOURCE_FILE > $TRANSFORM_SQL

echo "        MAP-FILE ADAPTOR EXECUTING SCRIPTS"
sqlplus -s /nolog << EOL 1> >(tee -a $PRECISION100_LOG_FOLDER/sql.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/sql-err.log >&2)
CONNECT $USERNAME/$PASSWORD@$SID
SET FEEDBACK OFF

@$O_TABLE_SQL
@$O_TAB_COLUMN_SQL
@$TRANSFORM_SQL

EOL


$PRECISION100_FOLDER/bin/audit.sh  $0 "POST-MAP-FILE" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "MAP-FILE" $0 "END"

echo "        END MAP-FILE ADAPTOR $FILE_NAME"
