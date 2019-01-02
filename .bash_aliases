# ls alias
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias mkdir="mkdir -p"
alias ln="ln -v"

# cd shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
alias g="git"
alias c="config"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Include custom aliases
[[ -f ~/.bash_aliases.local ]] && source ~/.bash_aliases.local
