#!/bin/bash

# MA22019 Data Backup Script
# This script creates a backup of all data files that are typically ignored by git.

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="backups"
ARCHIVE_NAME="ma22019_data_backup_${TIMESTAMP}.zip"

# Create backups directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Starting backup of data files to ${BACKUP_DIR}/${ARCHIVE_NAME}..."

# Zip command to find and archive specific file types and data folders
# - excludes the backup folder itself
# - includes slides/data, case_studies/data
# - includes specific extensions elsewhere if needed

zip -r "${BACKUP_DIR}/${ARCHIVE_NAME}" \
    assets/data \
    -i "*.csv" "*.shp" "*.shx" "*.dbf" "*.prj" "*.txt" "*.cpg" "*.nc" "*.zip"

echo "Backup complete: ${BACKUP_DIR}/${ARCHIVE_NAME}"
echo "Don't forget to move this backup to a safe location (e.g., OneDrive)!"
