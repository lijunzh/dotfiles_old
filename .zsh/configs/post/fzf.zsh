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
export FZF_DEFAULT_COMMAND='rg --files --ignore-case'
export FZF_DEFAULT_OPTS='
	--multi --layout=reverse --border --inline-info
	--bind ctrl-f:page-down,ctrl-b:page-up
	--preview "bat --color 'always' {}"'
	# --preview "(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200 {}"'
