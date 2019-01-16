#!/bin/bash
MIGRATION=$1
MIGRATION_SCRIPT="$MIGRATION.sh"
if [ -f $MIGRATION_FOLDER/$MIGRATION.txt ]; then
   filelines=`cat $MIGRATION_FOLDER/$MIGRATION.txt`
   echo "#!/bin/bash" >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'clear' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'echo' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'echo "***************************************************"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'echo "*                                                 *"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'echo "*          Precision 100 Framework                *"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'echo "*                                                 *"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'echo "***************************************************"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo "echo" >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo "PS3='Please enter your choice: (3 to quit) '" >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   menus=`cat $MIGRATION_FOLDER/$MIGRATION.txt | tr '\n' ' '`
   echo "options=($menus quit)" >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'select opt in "${options[@]}"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo "do" >>  $MIGRATION_FOLDER/$MIGRATION_SCRIPT
   echo 'case $opt in' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT

   for pipeline in $filelines ; do

       $PRECISION100_FOLDER/create_pipeline_script.sh $pipeline

       echo "\"$pipeline\")" >>  $MIGRATION_FOLDER/$MIGRATION_SCRIPT
       echo "$PIPELINE_FOLDER/$pipeline".sh >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
       #echo 'echo "you chose choice 1"' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
       echo '    ;;' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT

   done;

   echo '"quit")' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT 
   echo '   break ' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT 
   echo '   ;; ' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT 
   echo ' *) echo invalid option;;' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT 
   echo ' esac' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT 
   echo 'done' >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT 
   chmod u+x $MIGRATION_FOLDER/$MIGRATION_SCRIPT
fi
