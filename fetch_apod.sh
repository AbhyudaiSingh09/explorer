#!/bin/bash

# Check for API key as argument
if [ -z "$1" ]; then
  echo "❌ No API key provided. Usage: ./fetch_apod.sh <API_KEY>"
  exit 1
fi

API_KEY="$1"
DATE=$(date '+%Y-%m-%d')
OUTPUT_FILE="apod_${DATE}.md"
IMAGE_FILE="apod_${DATE}.jpg"

# Fetch APOD data
response=$(curl -s "https://api.nasa.gov/planetary/apod?api_key=$API_KEY")

# Parse response
title=$(echo "$response" | jq -r '.title')
apod_date=$(echo "$response" | jq -r '.date')
explanation=$(echo "$response" | jq -r '.explanation')
image_url=$(echo "$response" | jq -r '.url')
hd_image_url=$(echo "$response" | jq -r '.hdurl')
copyright=$(echo "$response" | jq -r '.copyright')

# Download image locally
curl -s "$image_url" -o "$IMAGE_FILE"

# Write to daily Markdown file
{
echo "# NASA Astronomy Picture of the Day - $apod_date"
echo
echo "**$title**"
echo
echo "![APOD Image]($IMAGE_FILE)"
echo
echo "$explanation"
[ "$copyright" != "null" ] && echo "📸 *Image credit: $copyright*"
} > "$OUTPUT_FILE"

# Update README.md with latest post
{
echo "# 🚀 NASA Astronomy Picture of the Day"
echo
echo "### 📅 $apod_date – **$title**"
echo
echo "![APOD Image]($IMAGE_FILE)"
echo
echo "$explanation"
[ "$copyright" != "null" ] && echo "*Image credit: $copyright*"
echo
echo "---"
echo "_This file is automatically updated daily via [NASA APOD API](https://api.nasa.gov/)._"
} > README.md

echo "✅ APOD saved to $OUTPUT_FILE and README.md updated"