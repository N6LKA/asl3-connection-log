#!/bin/bash
# Author: Larry K. Aycock (N6LKA)
# This script logs disconnections to a log file.
LOGFILE=/var/log/asterisk/connectlog
echo "$1 disconnected from $2 on $(date +"%T - %m-%d-%Y")" >> "$LOGFILE" 2>&1 || logger "Failed to write to $LOGFILE"
