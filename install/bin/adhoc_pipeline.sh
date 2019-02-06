#!/bin/bash

source ./conf/.env.sh

export OPERATION="ADHOC_PIPELINE"

cd $GIT_WORK_FOLDER
git pull origin $EXECUTION_NAME

PIPELINE=$1

$PRECISION100_FOLDER/exec_pipeline.sh $PIPELINE
