#!/bin/bash

# NASA API Key
API_KEY="EAZJyZnBcZ5U66Aw7PdRnAkkBvb49ahoJQe51sUW"
OUTPUT_FILE="apod_$(date '+%Y-%m-%d').md"

# Fetch APOD data
response=$(curl -s "https://api.nasa.gov/planetary/apod?api_key=$API_KEY")

# Parse response
title=$(echo "$response" | jq -r '.title')
date=$(echo "$response" | jq -r '.date')
explanation=$(echo "$response" | jq -r '.explanation')
image_url=$(echo "$response" | jq -r '.url')
copyright=$(echo "$response" | jq -r '.copyright')

# Write to Markdown file
{
echo "# NASA Astronomy Picture of the Day - $date"
echo
echo "**$title**"
echo
echo "![APOD Image]($image_url)"
echo
echo "$explanation"
echo
[ "$copyright" != "null" ] && echo "📸 *Image credit: $copyright*"
} > "$OUTPUT_FILE"

echo "✅ APOD saved to $OUTPUT_FILE"
