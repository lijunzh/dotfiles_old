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

	" autocompletion
	if has('nvim')
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#auto_complete_delay = 100

	" python syntax semantic highlighting
	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

	" auto foramt python code
	Plug 'sbdchd/neoformat'

	augroup fmt
		autocmd!
		autocmd BufWritePre * undojoin | Neoformat
	augroup END

call plug#end()
