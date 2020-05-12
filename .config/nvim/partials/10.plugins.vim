call plug#begin('~/.config/nvim/plugged')

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"	Appearance
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" color scheme
	Plug 'vim-scripts/Zenburn'
	Plug 'crusoexia/vim-monokai'

	" status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	set noshowmode

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"	Utilities
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	" fuzzy search
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" comments
	Plug 'tomtom/tcomment_vim'

	" auto closing quotes, paranthesis, etc.
	Plug 'vim-scripts/delimitMate.vim'
	" Python docstring
	let delimitMate_nesting_quotes = ['"','`']
	au FileType python let b:delimitMate_nesting_quotes = ['"']

	" autocompletion
	if has('nvim')
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deoplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif

	" language plugins
	Plug 'deoplete-plugins/deoplete-jedi'
	Plug 'deoplete-plugins/deoplete-go'

	" echodoc
	Plug 'Shougo/echodoc.vim'

	" tabnine
	Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

	" snippet
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'
	"Plug 'honza/vim-snippets'

	Plug 'Shougo/vimproc.vim', {'do' : 'make'}

	" netrw enchance
	Plug 'tpope/vim-vinegar'

	" bracekts mapping
	Plug 'tpope/vim-unimpaired'

	" surround
	Plug 'tpope/vim-surround'

	" Neomake
	Plug 'neomake/neomake'

	" ctags
	Plug 'ludovicchabant/vim-gutentags'

	" Markdown
	function! BuildComposer(info)
		if a:info.status != 'unchanged' || a:info.force
			if has('nvim')
				!cargo build --release
			else
				!cargo build --release --no-default-features --features json-rpc
			endif
		endif
	endfunction

	Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

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
	" rust.vim
	Plug 'rust-lang/rust.vim'

	" rustfmt
	let g:rustfmt_autosave = 1
	let g:rustfmt_command = 'rustup run stable rustfmt'

	" Racer for completion
	Plug 'racer-rust/vim-racer'
	let g:racer_cmd = '~/.cargo/bin/racer'
	set hidden
	let g:racer_experimental_completer = 1

	au FileType rust nmap gd <Plug>(rust-def)
	au FileType rust nmap gs <Plug>(rust-def-split)
	au FileType rust nmap gx <Plug>(rust-def-vertical)
	au FileType rust nmap <leader>gd <Plug>(rust-doc)

	" rusty-tags
	autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
	autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

call plug#end()

call neomake#configure#automake('nrwi', 500)

