call plug#begin('~/.config/nvim/plugged')

	" color scheme
	Plug 'vim-scripts/Zenburn'

	" status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" auto closing quotes, paranthesis, etc.
	Plug 'vim-scripts/delimitMate.vim'

call plug#end()
