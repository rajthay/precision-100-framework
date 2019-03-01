#!/bin/bash

if [[ ( "$#" -lt 1 ||  "$#" -gt 3 ) ]]; then
  echo "Usage: $0 data-flow-name [simulation-mode-true-false] [simulation-sleep-time-in-seconds]"
  exit 1;
fi

source ./conf/.env.sh

export OPERATION="ADHOC_DATAFLOW"

cd $GIT_WORK_FOLDER
#git pull origin $EXECUTION_NAME
./repo_refresh.sh $EXECUTION_NAME

DATAFLOW=$1
if [ ! -z "$2" ]; then
    export SIMULATION_MODE="TRUE"
fi
if [ ! -z "$3" ]; then
    export SIMULATION_SLEEP=$3
fi
echo "EXECUTING $OPERATION"
echo "SIMULATION MODE: $SIMULATION_MODE"
$PRECISION100_FOLDER/bin/exec_dataflow.sh $DATAFLOW