# manage dotfiles in bare git repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# use color ls
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

 if [ -f ~/.bash_aliases ]; then                                                 
     . ~/.bash_aliases                                                           
 fi 

# homebrew sbin
export PATH="/usr/local/sbin:$PATH"

# added by Anaconda3 installer
export PATH="/Users/lijun/anaconda3/bin:$PATH"

# added /home/lijun/bin
export PATH="/Users/lijun/bin:$PATH"

# add Anaconda to python path
export PYTHONPATH="$PATHONPATH:/home/lijun/anaconda3/lib/python3.6/site-packages"

