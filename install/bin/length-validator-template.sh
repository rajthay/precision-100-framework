#!/bin/bash

CONTAINER=$1
INDEX=$(echo $2 | cut -d ',' -f 1)
FILE_NAME=$(echo $2 | cut -d ',' -f 2)
FILE_TYPE=$(echo $2 | cut -d ',' -f 3)
VIEW_NAME=$(echo $2 | cut -d ',' -f 4)

echo "        START LENGTH-VALIDATOR ADAPTOR $FILE_NAME"

if test "$SIMULATION_MODE" = "TRUE"; then
   sleep $SIMULATION_SLEEP;
   echo "        END LENGTH-VALIDATOR ADAPTOR $FILE_NAME"
   exit;
fi

source $PRECISION100_FOLDER/conf/.length-validator.env.sh
mkdir -p $LENGTH_VALIDATOR_WORK_FOLDER;
if [[ -z "$VIEW_NAME" ]]; then
  VIEW_NAME="${DEFAULT_VIEW_PREFIX:-V}_${FILE_NAME}_${DEFAULT_VIEW_SUFFIX:-L}"
fi

$PRECISION100_FOLDER/bin/audit.sh  $0 "PRE-LENGTH-VALIDATOR" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "LENGTH-VALIDATOR" $0 "START"

echo "        LENGTH-VALIDATOR ADAPTOR CREATING VIEW SCRIPT"
$PRECISION100_FOLDER/bin/length-validator-generator.sh $FILE_NAME $VIEW_NAME > $LENGTH_VALIDATOR_WORK_FOLDER/$VIEW_NAME.sql

echo "        LENGTH-VALIDATOR ADAPTOR EXECUTING SCRIPTS"
sqlplus -s /nolog << EOL 1> >(tee -a $PRECISION100_LOG_FOLDER/sql.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/sql-err.log >&2)
CONNECT $USERNAME/$PASSWORD@$SID
SET FEEDBACK OFF

@$LENGTH_VALIDATOR_WORK_FOLDER/$VIEW_NAME.sql

EOL


$PRECISION100_FOLDER/bin/audit.sh  $0 "POST-LENGTH-VALIDATOR" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "LENGTH-VALIDATOR" $0 "END"

echo "        END LENGTH-VALIDATOR ADAPTOR $FILE_NAME"
