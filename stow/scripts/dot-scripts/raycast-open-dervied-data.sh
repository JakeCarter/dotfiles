#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Dervied Data
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils
# @raycast.description Opens the Xcode DerivedData folder in Finder

# Documentation:
# @raycast.author Jake Carter
# @raycast.authorURL https://raycast.com/jake_carter

DD_PATH="${HOME}/Library/Developer/Xcode/DerivedData"

if [ -e "${DD_PATH}" ]; then
    open -a Finder "${DD_PATH}"
else
    echo "Not Found"
fi
