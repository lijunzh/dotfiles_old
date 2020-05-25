if hash fzf 2>/dev/null; then
	# Setup fzf
	# ---------
	if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
	  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
	fi

	# Auto-completion
	# ---------------
	[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

	# Key bindings
	# ------------
	source "/usr/local/opt/fzf/shell/key-bindings.zsh"

	# Configuration
	# export FZF_DEFAULT_COMMAND='rg --files --hidden --ignore-case'
	export FZF_DEFAULT_COMMAND="fd --hidden --exclude '.git' . $HOME"
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
	export FZF_ALT_C_COMMAND="fd -t d . $HOME"
	export FZF_DEFAULT_OPTS='
		--multi --layout=reverse --border --inline-info
		--bind ctrl-f:page-down,ctrl-b:page-up
		--preview "bat --color 'always' {}"'
fi;
