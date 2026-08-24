#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete Derived Data
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils
# @raycast.description Deletes the Xcode DerivedData folder
# @raycast.needsConfirmation true

# Documentation:
# @raycast.author Jake Carter
# @raycast.authorURL https://raycast.com/jake_carter

DD_PATH="${HOME}/Library/Developer/Xcode/DerivedData"

if [ -e "${DD_PATH}" ]; then
    rm -rf "${DD_PATH}"
    echo "Deleted"
else
    echo "Not Found"
fi
