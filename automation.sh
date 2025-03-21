#!bin/bash

LOG_FILE="/home/Hudson-ubuntu/Desktop/Praktikum_1/ignatius/cloud_log.txt"
CRON_JOB="*/2 * * * * /home/Hudson-ubuntu/Desktop/Praktikum_1/ignatius/download.sh >> /home/Hudson-ubuntu/Desktop/Praktikum_1/ignatius/testfile.txt"

# Read the latest status from log file
value=$(tac "$LOG_FILE" | grep -m1 -E 'LOGOUT|LOGIN')

if echo "$value" | grep -q "LOGOUT"; then
    echo "User logged out, stopping cron job..."
    crontab -l | grep -v "download.sh" | crontab -  # Remove cron job
    echo "Cron job removed."
elif echo "$value" | grep -q "LOGIN"; then
    echo "User logged in, ensuring cron job is running..."

    # Check if the cron job already exists before adding
    if crontab -l | grep -q "download.sh"; then
        echo "Cron job already exists, skipping..."
    else
        (crontab -l; echo "$CRON_JOB") | crontab -
        echo "Cron job added."
    fi
fi


