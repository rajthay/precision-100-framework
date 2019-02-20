#!/bin/bash

source ./conf/.env.sh

export OPERATION="ADHOC_DATAFLOW"

cd $GIT_WORK_FOLDER
git pull origin $EXECUTION_NAME

DATAFLOW=$1

$PRECISION100_FOLDER/bin/exec_dataflow.sh $DATAFLOW
