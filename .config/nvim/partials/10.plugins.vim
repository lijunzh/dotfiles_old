call plug#begin('~/.config/nvim/plugged')

	" color scheme
	Plug 'vim-scripts/Zenburn'

	" status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	set noshowmode

	" auto closing quotes, paranthesis, etc.
	Plug 'vim-scripts/delimitMate.vim'

	" code snippets
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	" trigger configuration
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumForwardTrigger="<tab>"
	let g:UltiSnipsListSnippets="<c-tab>"

call plug#end()
