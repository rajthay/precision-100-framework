#!/bin/bash

DATAFLOW=$1

echo "START POST DATAFLOW $DATAFLOW"

$PRECISION100_FOLDER/bin/audit.sh  $0 "POST-DATAFLOW" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $DATAFLOW" "$PROJECT_FOLDER / $EXECUTION_NAME" "DATAFLOW" $DATAFLOW "END"

echo "END POST DATAFLOW $DATAFLOW"
