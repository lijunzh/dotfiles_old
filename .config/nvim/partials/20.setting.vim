"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	Basic Settings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ecnoding
set encoding=utf-8

" trigger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

set history=1000

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/vim/undo
endif

" do not create backups when editing certain directories
set backupskip=/tmp/*,/private/tmp/*

" do not add empty newline at the end of files
set binary
se noeol

" do not respect modeline in source file
set nomodeline
set exrc
set secure

if has('mouse')
	set mouse=a
endif

set clipboard=unnamed	" use system clipboard
set backspace=	" use default vim backspace

" search setup
set incsearch	" incremental search
set ignorecase	" ignore case in search
set smartcase	" case-sensitive if expression contains a captial letter
set nolazyredraw	" do not redraw while executing macros
" search highlight only when search
augroup vimSearchHighligh
	autocmd!

	autocmd CmdlineEnter /,\? :set hlsearch
	autocmd CmdlineLeave /,\? :set nohlsearch

set magic	" set magic on for regex

set nojoinspaces	" one space, not two, after punctuation
set complete+=kspell

set ttyfast	" optimize for fast tty
set path+=**	" add current directory to path


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	Automation
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save all file on focus lost
set autowriteall
augroup vimAutoSave
	autocmd!

	autocmd FocusLost * silent! wa

augroup END

" automatically remove tailing whitespace on save
augroup vimRemoveTail
	autocmd!

	autocmd BufWritePre * :%s/\s\+$//e

augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	Language Specific
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set python program
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" force latex flavor
let g:tex_flavor="latex"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Snippet Setting
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" reference: https://github.com/Shougo/neosnippet.vim
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=0 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
"let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'