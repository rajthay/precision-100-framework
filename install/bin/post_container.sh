#!/bin/bash

CONTAINER=$1

echo "    START POST CONTAINER $CONTAINER"

$PRECISION100_FOLDER/bin/audit.sh  $0 "POST-CONTAINER" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $CONTAINER" "$PROJECT_FOLDER / $EXECUTION_NAME" "CONTAINER" $CONTAINER "END"

echo "    END POST CONTAINER $CONTAINER"
