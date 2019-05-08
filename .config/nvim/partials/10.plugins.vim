call plug#begin('~/.config/nvim/plugged')

	" color scheme
	Plug 'vim-scripts/Zenburn'

	" status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	set noshowmode

	" auto closing quotes, paranthesis, etc.
	Plug 'vim-scripts/delimitMate.vim'

	" surroundings
	Plug 'tpope/vim-surround'

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
	let python_highlight_all=1
	Plug 'Kareeeeem/python-docstring-comments'
	Plug 'tweekmonster/impsort.vim'

	" python indent
	Plug 'vimjas/vim-python-pep8-indent'

	" python folding
	Plug 'tmhedberg/SimpylFold'
	set foldlevelstart=20

	" netrw enchance
	Plug 'tpope/vim-vinegar'
	"let g:netrw_liststyle = 3
	"let g:netrw_browse_split = 4
	"let g:netrw_altv = 1
	"let g:netrw_winsize = 10

	" rust plugin
	"Plug 'rust-lang/rust.vim'

	" Neomake
	Plug 'neomake/neomake'

	" ctags
	Plug 'ludovicchabant/vim-gutentags'

call plug#end()

call neomake#configure#automake('nrwi', 500)

