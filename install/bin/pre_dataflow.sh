#!/bin/bash

DATAFLOW=$1

echo "START PRE DATAFLOW $DATAFLOW"

$PRECISION100_FOLDER/bin/audit.sh  $0 "PRE-DATAFLOW" "$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $DATAFLOW" "$PROJECT_FOLDER / $EXECUTION_NAME" "DATAFLOW" $DATAFLOW "START"

echo "END PRE DATAFLOW $DATAFLOW"
