CONTAINER=$1
FILE_NAME=$(echo $2 | cut -d ',' -f 2)
FILE_TYPE=$(echo $2 | cut -d ',' -f 3)
CONNECTION_NAME=$(echo $2 | cut -d ',' -f 4)
echo "        START SQL ADAPTOR $CONTAINER_FOLDER/$CONTAINER/$FILE_NAME"

if test "$SIMULATION_MODE" = "TRUE"; then
   sleep $SIMULATION_SLEEP;
   echo "        END SQL ADAPTOR $CONTAINER_FOLDER/$CONTAINER/$FILE_NAME"
   exit;
fi

if [[ -z "$CONNECTION_NAME" ]]; then
   CONNECTION_NAME="$PRECISION100_CONNECTION"
fi
CONNECTION_STRING=$($PRECISION100_FOLDER/bin/get-connection-string.sh "$CONNECTION_NAME")

$PRECISION100_FOLDER/bin/audit.sh  $0 "PRE-SQl" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "SQL" $0 "START"

sqlplus -s /nolog << EOL
CONNECT $CONNECTION_STRING
SET FEEDBACK OFF

@$CONTAINER_FOLDER/$CONTAINER/$FILE_NAME

EXIT

EOL
$PRECISION100_FOLDER/bin/audit.sh  $0 "POST-SQl" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "SQL" $0 "END"

echo "        END SQL ADAPTOR $CONTAINER_FOLDER/$CONTAINER/$FILE_NAME"
