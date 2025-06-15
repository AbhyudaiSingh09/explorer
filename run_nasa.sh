#!/bin/bash

# Check for API key argument
if [ -z "$1" ]; then
  echo "❌ Usage: ./run_nasa.sh <API_KEY>"
  exit 1
fi

API_KEY="$1"
DATE=$(date '+%Y-%m-%d')
IMAGE_FILE="apod_${DATE}.jpg"

# Run fetch script with API key
./fetch_apod.sh "$API_KEY"

# Commit and push
git add .
git commit -m "Update APOD for $DATE"
git push origin main

# Remove image after push
if [ -f "$IMAGE_FILE" ]; then
  rm "$IMAGE_FILE"
  echo "🗑️ Deleted image file: $IMAGE_FILE"
fi