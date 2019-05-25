call plug#begin('~/.config/nvim/plugged')

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"	Appearance
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" color scheme
	Plug 'vim-scripts/Zenburn'

	" status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	set noshowmode

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"	Utilities
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" auto closing quotes, paranthesis, etc.
	Plug 'vim-scripts/delimitMate.vim'

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

	" snippet
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'
	Plug 'honza/vim-snippets'

	Plug 'Shougo/vimproc.vim', {'do' : 'make'}

	" netrw enchance
	Plug 'tpope/vim-vinegar'

	" Neomake
	Plug 'neomake/neomake'

	" ctags
	Plug 'ludovicchabant/vim-gutentags'

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"	Python
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" python syntax semantic highlighting
	let python_highlight_all=1
	Plug 'Kareeeeem/python-docstring-comments'
	Plug 'tweekmonster/impsort.vim'

	" python indent
	Plug 'vimjas/vim-python-pep8-indent'

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"	LaTeX
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" vimtex plugin
	Plug 'lervag/vimtex'
	let g:vimtex_compiler_progname = 'nvr'

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"	Rust
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'racer-rust/vim-racer'
	set hidden
	let g:racer_experimental_completer = 1

	au FileType rust nmap gd <Plug>(rust-def)
	au FileType rust nmap gs <Plug>(rust-def-split)
	au FileType rust nmap gx <Plug>(rust-def-vertical)
	au FileType rust nmap <leader>gd <Plug>(rust-doc)

call plug#end()

call neomake#configure#automake('nrwi', 500)

