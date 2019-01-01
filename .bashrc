################################################################################
#
#							Gobal Setup	
#
################################################################################

# manage dotfiles in bare git repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# added /home/lijun/bin
export PATH="$HOME/bin:$PATH"

# custom aliases
if [ -f ~/.bash_aliases ]; then                                                 
    . ~/.bash_aliases                                                           
fi 

################################################################################
#
#							Mac OS Setup
#
################################################################################

if [[ $(sw_vers -productName) == "Mac OS X" ]]; then

	# use color ls
	export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
	export CLICOLOR=1
	export LSCOLORS=ExFxBxDxCxegedabagacad
	alias ls='ls -GFh'

	# homebrew sbin
	export PATH="/usr/local/sbin:$PATH"

fi

################################################################################
#
#							Anaconda Setup
#
################################################################################

if [[ -d "$HOME/anaconda3" ]]; then

	# added by Anaconda3 installer
	export PATH="$HOME/anaconda3/bin:$PATH"

	# add Anaconda to python path
	export PYTHONPATH="$PATHONPATH:$HOME/anaconda3/lib/python3.6/site-packages"

fi

