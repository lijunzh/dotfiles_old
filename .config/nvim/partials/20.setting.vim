set autoread	" detect when a file is changed

set history=1000	
set textwidth=80

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