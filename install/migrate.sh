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
function banner() {
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
}

function ask_question() {
  if [ -s $1 ]; then
    echo ".."
    sleep 1
    echo "...."
    sleep 1
    echo "......"
    sleep 1
    echo "........"
    sleep 1
    echo "......"
    sleep 1
    echo "...."
    sleep 1
    echo ".."
    sleep 1
    echo "Log file $1 created"
    echo "Would you like to view the log file ?"
    select yn in "Yes" "No"; do
      case $yn in
        "Yes") 
          vi $1
          break;;
        "No") 
          break;;
      esac
    done
  fi
}

function main_loop() {
  banner
  select i in $DATAFLOW_FILES "Quit";
  do
    case $i in 
      "Quit")
         exit;
      ;;
      *)
	log_file_name="$PRECISION100_LOG_FOLDER/${i}-$(date +%F-%H-%M-%S).out"
	err_file_name="$PRECISION100_LOG_FOLDER/${i}-$(date +%F-%H-%M-%S).err"
        $PRECISION100_FOLDER/bin/exec_dataflow.sh ${i%.*} 1> >(tee -a "$log_file_name") 2> >(tee -a "$err_file_name" >&2)

	ask_question ${log_file_name}
	break;;
    esac;
  done;
}

while true
do
   main_loop;
done
