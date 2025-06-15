# Update README.md
{
echo "# 🚀 NASA Astronomy Picture of the Day"
echo
echo "### 📅 $date – **$title**"
echo
echo "![APOD Image]($image_url)"
echo
echo "$explanation"
echo
[ "$copyright" != "null" ] && echo "*Image credit: $copyright*"
echo
echo "---"
echo "_This file is automatically updated daily via [NASA APOD API](https://api.nasa.gov/)._"
} > README.md# explorer
