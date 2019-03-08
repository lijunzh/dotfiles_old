" ecnoding
set encoding=utf-8

" set python program
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

set autoread	" detect when a file is changed

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

" save all file on focus lost
augroup vimAutoSave
	autocmd!

	autocmd FocusLost * silent wa

augroup END

" automatically remove tailing whitespace on save
augroup vimRemoveTail
	autocmd!

	autocmd BufWritePre * :%s/\s\+$//e

augroup END

" force latex flavor
let g:tex_flavor="latex"

