CONTAINER=$1
INDEX=$(echo $2 | cut -d ',' -f 1)
FILE_NAME=$(echo $2 | cut -d ',' -f 2)
FILE_TYPE=$(echo $2 | cut -d ',' -f 3)
DELIMITER=$(echo $2 | cut -d ',' -f 4)
QUOTE=$(echo $2 | cut -d ',' -f 5)

source $PRECISION100_FOLDER/conf/.spool.env.sh

if [ -z "$DELIMITER" ]; then
    DELIMITER=${DEFAULT_DELIMITER:-,}
fi
if [ -z "$QUOTE" ]; then
    QUOTE=${DEFAULT_QUOTE:-OFF}
fi

echo "        START SPOOL ADAPTOR $FILE_NAME"

if test "$SIMULATION_MODE" = "TRUE"; then
   sleep $SIMULATION_SLEEP;
   echo "        END SPOOL ADAPTOR $FILE_NAME"
   exit;
fi

mkdir -p "$SPOOL_PATH"

$PRECISION100_FOLDER/bin/audit.sh  $0 "PRE-SPOOL" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "SPOOL" $0 "START"

$PRECISION100_FOLDER/bin/spool.sh $FILE_NAME $DELIMITER $QUOTE

$PRECISION100_FOLDER/bin/audit.sh  $0 "POST-SPOOL" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "SPOOL" $0 "END"

echo "        END SPOOL ADAPTOR $FILE_NAME"
