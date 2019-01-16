#!/bin/bash

PIPELINE=$1
PIPELINE_SCRIPT="$PIPELINE".sh
if [ -f $PIPELINE_FOLDER/$PIPELINE.txt ]; then
   filelines=`cat $PIPELINE_FOLDER/$PIPELINE.txt`
   echo "#!/bin/bash" >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'clear' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'echo' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'echo "***************************************************"' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'echo "*                                                 *"' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'echo "*          Precision 100 Framework                *"' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'echo "*                                                 *"' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'echo "***************************************************"' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo "echo" >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo "PS3='Please enter your choice: (3 to quit) '" >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   menus=`cat $PIPELINE_FOLDER/$PIPELINE.txt | tr '\n' ' '`
   echo "options=($menus quit)" >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'select opt in "${options[@]}"' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo "do" >>  $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   echo 'case $opt in' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT

   for container in $filelines ; do

       $PRECISION100_FOLDER/create_container_script.sh $container

       echo "\"$container\")" >>  $PIPELINE_FOLDER/$PIPELINE_SCRIPT
       echo "$CONTAINER_FOLDER/$container/container.sh" >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
       #echo 'echo "you chose choice 1"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
       echo '    ;;' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT
   done;

   echo '"quit")' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT 
   echo '   break ' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT 
   echo '   ;; ' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT 
   echo ' *) echo invalid option;;' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT 
   echo ' esac' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT 
   echo 'done' >> $PIPELINE_FOLDER/$PIPELINE_SCRIPT 
   chmod u+x $PIPELINE_FOLDER/$PIPELINE_SCRIPT
fi
