#!/bin/bash

##### Settings #####
# Server file name.
fileName=server.jar
# Starting memory of your server (M - Megabytes, G - Gigabytes).
strMemory=2G
# Max memory which can be used by the server (M - Megabytes, G - Gigabytes). 
maxMemory=8G
# After how many days backups should be deleted?
daysToDelete=7
####################

while true
    do
        java -Xms${strMemory} -Xmx${maxMemory} -jar $fileName nogui
        echo ------- RESTARTING -------
        now=`date +'%m-%d-%Y-%H:%M'`
        echo ${now} Server Restart. Creating world backup... >> serverlog.txt
        find backup/ -type f -name '*.zip' -mtime +${daysToDelete} -exec rm {} ;
        zip -r backup/backup-${now}.zip world world_nether world_the_end
        echo ${now} Created Backup. Starting server. >> serverlog.txt
    done