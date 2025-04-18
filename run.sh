#!/bin/bash
# This script is used to run a Minecraft server with specific Java flags and create backups of the world. Created by februu @github.com/februu.

##### Arguments #####
# Server file name.
fileName=$1
# Starting memory of your server (M - Megabytes, G - Gigabytes).
maxMemory=$2
# After how many days backups should be deleted?
daysToDelete=$3
####################

if [ $# -ne 3 ]; then
    echo "Usage: $0 <server_file_name.jar> <memory_amount> <days_to_keep_backups>"
    echo "Example: $0 server.jar 4G 7"
    echo "This will run server.jar with 4GB of memory and keep backups for 7 days."
    exit 1
fi

mkdir -p backup

while true
    do
        java -Xms"${maxMemory}" -Xmx"${maxMemory}" -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar "${fileName}" nogui
        now=$(date +'%m-%d-%Y-%H:%M')
        echo "${now} Server is restarting. Creating world backup..."
        find backup/ -type f -name '*.zip' -mtime +"${daysToDelete}" -exec rm {} \;
        zip -r "backup/backup-${now}.zip" world world_nether world_the_end 2>/dev/null
        echo "${now} Backup created successfully. Starting server..."
    done