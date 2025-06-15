#!/bin/bash

./fetch_apod.sh

git add .
git commit -m "Update APOD for $(date '+%Y-%m-%d')"
git push origin main
