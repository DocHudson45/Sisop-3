#!/bin/bassh

# Get the current time and date
CURRENT_HOUR=$(date +"%H")
CURRENT_DAY=$(date +"%d")
CURRENT_MONTH=$(date +"%m")
CURRENT_YEAR=$(date +"%Y")

# Extract the latest username from the log
log_file="cloud_storage/cloud_log.txt"
username=$(grep 'LOGIN: INFO User' "$log_file" | tail -n 1 | awk '{print $6}')

# Check if username is captured
if [ -z "$username" ]; then
    echo "Error: No valid username found in the log."
    exit 1
fi

# Check if the last logged action is a logout
last_action=$(grep "User $username" "$log_file" | tail -n 1)
if echo "$last_action" | grep -q "logged out"; then
    echo "No user is currently logged in. No archiving performed."
    exit 1
fi

# Define paths
download_dir="cloud_storage/downloads/$USERNAME"
archive_dir="cloud_storage/archives/$USERNAME"

# Ensure the archive directory exists
mkdir -p "$archive_dir"

# Archive file name with detailed timestamp
archive_name="archive_${CURRENT_DAY}_${CURRENT_MONTH}_${CURRENT_YEAR}_$(date +"%H%M%S").zip"

# Check if the download directory exists and contains files
if [ -d "$download_dir" ] && [ "$(ls -A $download_dir)" ]; then
    # Create ZIP archive of the downloaded images
    zip -r "$archive_dir/$archive_name" "$download_dir"

    # Verify the archive was created successfully
    if [ $? -eq 0 ]; then
        echo "Archive created: $archive_dir/$archive_name"

        # Delete original files after successful archiving
        rm -rf "$download_dir"/*
        echo "Original files deleted."
    else
        echo "Error: Failed to create archive."
        exit 1
    fi
else
    echo "No files to archive in $download_dir."
fi


