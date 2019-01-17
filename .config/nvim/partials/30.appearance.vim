" color scheme
color Zenburn


set number	" line number

" toggle number in hybrid mode
augroup vimHybridLN
	autocmd!

	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber

augroup END

" line wrap
set nowrap	" turn line wrap off
set linebreak	" soft wrapping
set showbreak=…	" show ellipsis at breaking

set autoindent	" autoindent
set laststatus=2	" show the status line all the time
let g:airline_theme='zenburn'
set wildmenu
set hidden
set showcmd
set wildmode=list:longest	" complete files like a shell
set shell=$SHELL
set title
set showmatch

" split bottom and right
set splitright
set splitbelow


" 80 column line
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=238 guibg=lightgrey
augroup texNoWrap
	autocmd!

	" remove 80 textwidth for text files
	autocmd Filetype tex,plaintex,markdown,text setlocal tw=0 wrap

augroup END

" default tab
set noexpandtab				" insert tabs instead of spaces
set smarttab					" tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2					" visible width of a tab
set softtabstop=2			" edit as if the tabs are
set shiftwidth=2
set shiftround

" language-speicific tab setting
"
augroup vimTabLanguage
	autocmd!

	" python always use 4 spaces instead of 1 tab
	autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab

augroup END

" list
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set shortmess=I	" no intro message
set showmode


" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
augroup vimLastCursorPosition
	autocmd!

	autocmd BufReadPost *
	  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
	  \   exe "normal g`\"" |
	  \ endif

augroup END

" automatically remove tailing whitespace on save
augroup vimRemoveTail
	autocmd!

	autocmd BufWrite * :%s/\s\+$//e

augroup END

