alias ls='ls -G'
alias la='ls -lah'
alias gs='git status'
alias a86='arch -x86_64'

alias ds='dirs -v'
# Create aliases 1-9 for hopping around the dir stack (i.e. alias 1='cd +1')
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias -s storyboard=bat
alias -s xib=bat
alias -s plist='plutil -p'