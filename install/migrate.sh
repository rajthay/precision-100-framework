#!/bin/bash

export NLS_LANG=.UTF8

if [[ ( "$#" -gt 2 ) ]]; then
  echo "Usage: $0 [simulation-mode-true-false] [simulation-sleep-time-in-seconds]"
  exit 1;
fi

source ./conf/.env.sh
if [ ! -z "$1" ]; then
    export OPERATION_MODE="PROD"
fi
if [ ! -z "$2" ]; then
    export SIMULATION_MODE="TRUE"
fi

export OPERATION="migrate.sh"

DATAFLOW_FILES=$($PRECISION100_FOLDER/bin/get-dataflows.sh)
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
  echo "  Operation Mode: $OPERATION_MODE                               "
  echo "                                                                "
  echo "  Simulation Mode: $SIMULATION_MODE                             "
  echo "                                                                "
  echo "                                                                "
  echo "****************************************************************"
}

function ask_question() {
  local log_size="$(wc -c < "$1")"
  local err_size="$(wc -c < "$2")"

  if [[ "PROD" = "$OPERATION_MODE" ]]; then 
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
  fi

  while true 
  do 
    banner
    echo "Log file of size $log_size: $1 created"
    echo "Err file of size $err_size: $2 created"
    echo "Would you like to view the log file(s) ?"
    select yn in "Log file" "Err file" "Back to Menu"; do
      case $yn in
        "Log file") 
          vi $1
	  break;;
        "Err file") 
	  vi $2
	  break;;
        "Back to Menu") 
	  return;
      esac
    done
  done
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

	ask_question "${log_file_name}" "${err_file_name}"
	break;;
    esac;
  done;
}

while true
do
   main_loop;
done
