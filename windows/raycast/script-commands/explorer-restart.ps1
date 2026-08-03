# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Windows Explorer
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📁

# Documentation:
# @raycast.author nivx18818
# @raycast.authorURL https://raycast.com/nivx18818

taskkill /f /im explorer.exe
start explorer.exe
