#!/bin/bash

if [[ ( "$#" -lt 2 ||  "$#" -gt 3 ) ]]; then
  echo "Usage: $0 container-name file-name [simulation-mode-true-false] [simulation-sleep-time-in-seconds]"
  exit 1;
fi
source ./conf/.env.sh

export OPERATION="ADHOC"

cd $REPO_WORK_FOLDER

$PRECISION100_FOLDER/bin/repo_refresh.sh

CONTAINER=$1
FILE_NAME=$2

LINE=`grep $FILE_NAME $CONTAINER_FOLDER/$CONTAINER/file.txt`

filename=$(echo $LINE | cut -d ',' -f 2)
filetype=$(echo $LINE | cut -d ',' -f 3)

if [ ! -z "$3" ]; then
    export SIMULATION_MODE="TRUE"
fi
if [ ! -z "$4" ]; then
    export SIMULATION_SLEEP=$3
fi
echo "EXECUTING $OPERATION"
echo "SIMULATION MODE: $SIMULATION_MODE"
$PRECISION100_FOLDER/bin/exec_file.sh $CONTAINER $filename $filetype
