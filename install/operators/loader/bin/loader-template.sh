CONTAINER=$1
INDEX=$(echo $2 | cut -d ',' -f 1)
FILE_NAME=$(echo $2 | cut -d ',' -f 2)

source $PRECISION100_FOLDER/conf/.sql-loader.env.sh

LOADER_FILE_NAME=${FILE_NAME%.*}
CONTROL_FILE="$CONTAINER_FOLDER/$CONTAINER/$LOADER_FILE_NAME.ctl"
DATA_FILE="$SQLLDR_INPUT/$LOADER_FILE_NAME.dat"
LOG_FILE="$SQLLDR_LOG/$LOADER_FILE_NAME.log"
BAD_FILE="$SQLLDR_BAD/$LOADER_FILE_NAME.bad"


DIRECT=${DEFAULT_DIRECT:-TRUE}
ERRORS=${DEFAULT_ERRORS:-1000000}
BINDSIZE=${DEFAULT_BINDSIZE:-5048576}
MULTITHREADING=${DEFAULT_MULTITHREADING:-TRUE}

echo "        START SQL_LOADER ADAPTOR $FILE_NAME"

if test "$SIMULATION_MODE" = "TRUE"; then
   sleep $SIMULATION_SLEEP;
   echo "        END SQL_LOADER ADAPTOR $FILE_NAME"
   exit;
fi

mkdir -p "$SQLLDR_LOG"
mkdir -p "$SQLLDR_BAD"

$PRECISION100_FOLDER/bin/audit.sh  $0 "PRE-LOADER" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "LOADER" $0 "START"

sqlldr control=$CONTROL_FILE data=$DATA_FILE log=$LOG_FILE bad=$BAD_FILE direct=$DIRECT errors=$ERRORS bindsize=$BINDSIZE multithreading=$MULTITHREADING << LOADER 1> >(tee -a $PRECISION100_LOG_FOLDER/loader.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/loader-err.log >&2)
$USERNAME/$PASSWORD@$SID
LOADER

$PRECISION100_FOLDER/bin/audit.sh  $0 "POST-LOADER" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER / $FILE_NAME" "$PROJECT_FOLDER / $EXECUTION_NAME" "LOADER" $0 "END"

echo "        END SQL_LOADER ADAPTOR $FILE_NAME"
