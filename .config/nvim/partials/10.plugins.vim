call plug#begin('~/.config/nvim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	appearance
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color scheme
Plug 'phanviet/vim-monokai-pro'

" status bar
Plug 'itchyny/lightline.vim'
let g:lightline = {
  \   'colorscheme': 'monokai_pro',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component': {
  \     'lineinfo': ' %3l:%-2v',
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'cocstatus': 'coc#status',
  \   }
  \ }
let g:lightline.separator = {
  \   'left': '❱', 'right': '❰'
  \}
let g:lightline.subseparator = {
  \   'left': '❭', 'right': '❬'
  \}
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	utilities
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" programming language
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

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

" table
Plug 'dhruvasagar/vim-table-mode'

" netrw enchance
Plug 'tpope/vim-vinegar'

" File system
Plug 'KenN7/vim-arsync'

" bracekts mapping
Plug 'tpope/vim-unimpaired'

" surround
Plug 'tpope/vim-surround'

" repeat plugin map (for surround)
Plug 'tpope/vim-repeat'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ctags
Plug 'ludovicchabant/vim-gutentags'

" toml
Plug 'cespare/vim-toml'

" tabularize
Plug 'godlygeek/tabular'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	Python
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python syntax semantic highlighting
let python_highlight_all=1
Plug 'Kareeeeem/python-docstring-comments'
Plug 'tweekmonster/impsort.vim', {'for': 'python'}


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
Plug 'rust-lang/rust.vim', {'for': 'rust'}

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
