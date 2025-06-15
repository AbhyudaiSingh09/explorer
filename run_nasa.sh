#!/bin/bash

# Run the script that fetches APOD and generates output
./fetch_apod.sh

# Get today's date for image file name
DATE=$(date '+%Y-%m-%d')
IMAGE_FILE="apod_${DATE}.jpg"

# Commit and push the changes
git add .
git commit -m "Update APOD for $DATE"
git push origin main

# Delete the image after successful push
if [ -f "$IMAGE_FILE" ]; then
  rm "$IMAGE_FILE"
  echo "🗑️ Deleted image file: $IMAGE_FILE"
else
  echo "⚠️ Image file not found: $IMAGE_FILE"
fi