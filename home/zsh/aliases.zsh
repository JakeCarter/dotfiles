alias ls='ls -G'
alias la='ls -lah'
alias gs='git status'
alias a86='arch -x86_64'
alias zq='zoxide query'

# Alias for finding the path to the currently selected Xcode's app root path
# Assuming Xcode is installed at "/Applications/Xcode.app"
#   `xcode-select -p` would return "/Applications/Xcode.app/Contents/Developer"
#   `xp` would return "/Applications/Xcode.app"
alias xp='xcode-select -p | xargs dirname | xargs dirname'

alias ds='dirs -v'
# Create aliases 1-9 for hopping around the dir stack (i.e. alias 1='cd +1')
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias -s storyboard=bat
alias -s xib=bat
alias -s plist='plutil -p'

# xcodebuild
alias -g SBS='-showBuildSettings'
