#!/bin/bash

if [[ ( "$#" -gt 2 ) ]]; then
  echo "Usage: $0 [simulation-mode-true-false] [simulation-sleep-time-in-seconds]"
  exit 1;
fi

source ./conf/.env.sh
if [ ! -z "$1" ]; then
    export SIMULATION_MODE="TRUE"
fi
if [ ! -z "$2" ]; then
    export SIMULATION_SLEEP=$2
fi

export OPERATION="migrate.sh"

DATAFLOW_FILES=`basename --suffix .txt -a $DATAFLOW_FOLDER/*.txt`
echo $DATAFLOW_FILES;
clear
echo "****************************************************************"
echo "                                                                "
echo "                  Precision 100 Execution                       "
echo "                                                                "
echo "  Project Name: $PROJECT_FOLDER                                 "
echo "                                                                "
echo "  Iteration: $EXECUTION_NAME                                    "
echo "                                                                "
echo "  Simulation Mode: $SIMULATION_MODE                             "
echo "                                                                "
echo "****************************************************************"
select i in $DATAFLOW_FILES "Quit";
do
    case $i in 
      "Quit")
         break;
      ;;
      *)
        $PRECISION100_FOLDER/bin/exec_dataflow.sh ${i%.*} 1> >(tee -a $PRECISION100_LOG_FOLDER/stdout.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/stderr.log >&2)
        break;
    esac;
done;
