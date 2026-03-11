#!/bin/bash
# This script logs connections to a log file.
LOGFILE=/var/log/asterisk/connectlog
echo "$1 connected to $2 on $(date +"%T - %m-%d-%Y")" >> "$LOGFILE" 2>&1 || logger "Failed to write to $LOGFILE"
