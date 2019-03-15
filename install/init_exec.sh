#!/bin/bash

source ./conf/.env.sh

DEFAULT_EXECUTION_NAME="mock1"
read -p "Enter Execution Name [$DEFAULT_EXECUTION_NAME] " INPUT_EXECUTION_NAME
EXECUTION_NAME=${INPUT_EXECUTION_NAME:-$DEFAULT_EXECUTION_NAME}

EXECUTION_CONF_FILE_NAME="$EXECUTION_NAME.env.sh"

cat > $PRECISION100_FOLDER/conf/$EXECUTION_CONF_FILE_NAME << EOL
export EXECUTION_NAME=$EXECUTION_NAME
export PRECISION100_WORK_FOLDER=$PRECISION100_FOLDER/$EXECUTION_NAME
EOL

ln -f -s $PRECISION100_FOLDER/conf/$EXECUTION_CONF_FILE_NAME $PRECISION100_FOLDER/conf/.execution.env.sh

source ./conf/.env.sh

mkdir -p "$REPO_WORK_FOLDER"
mkdir -p "$PRECISION100_LOG_FOLDER"

#git clone "$REPO_URL" "$REPO_WORK_FOLDER"
$PRECISION100_FOLDER/bin/repo_clone.sh

cd "$REPO_WORK_FOLDER"

$PRECISION100_FOLDER/bin/repo_operations.sh
