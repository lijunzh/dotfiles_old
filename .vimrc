" Lijun Zhu
" https://lijunzhu.info



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                           General Settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent                  " copy indent from current line fro new line
set autowrite                   " automatically :w before running commands
set clipboard=unnamed           " use OS clipboard by default

" Expand tab to 4 spaces
set tabstop=4                   " tab = 4 spaces
set expandtab                   " repace tab by spaces
set shiftwidth=4                " leading tab is measured in 4 spaces
set smarttab                    " delete one shiftwidth for leading spaces

set nojoinspaces                " one space, not two, after punctuation
set complete+=kspell            " complete with dictionary when spell check on

set ttyfast                     " optimize for fast tty
set path+=**
set wildmenu                    " command completion
set encoding=utf-8 nobomb       " use UTF-8 without BOM

" Do not add empty newline at the end of files
set binary
set noeol

" Generalize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Do not create backups when editing certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

set incsearch                   " incremental search
set ignorecase                  " ignore case in search
set mouse=a                     " enable mouse in all modes

" Vim-Plug 
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                              Appearance
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle relative mode only in normal mode
set number relativenumber

" Set the statusline
set laststatus=2                " always display the status line
set statusline=%F               " path to the file
set statusline+=%m              " modified flag
set statusline+=%r              " readonly flag
set statusline+=%y              " filetype of the file
set statusline+=%=              " switch to the right side
set statusline+=Current:\ %-4l  " display current line
set statusline+=Total:\ %-4L    " display total lines

set cursorline                  " always show current line
set titlestring=%f title
set showcmd                     " display incomplete commands
set splitbelow                  " split below and left
set scrolloff=8

" Limit text width in 80 characters
set textwidth=80
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight LineNr ctermfg=darkgrey
highlight Pmenu ctermfg=gray ctermbg=black

" Set list character but no enable list by default
set lcs+=tab:>-,trail:~,extends:>,precedes:<

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set shortmess=atI               " do not show intro message when starting vim
set showmode


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                               Auto Command
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrcEx
    autocmd!

    " Toggle number in hybrid mode
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

    " Toggle search highligh only when search
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
    autocmd BufRead,BufNewFile bash_aliases.local set filetype=sh
    autocmd BufRead,BufNewFile bash_exports set filetype=sh
    autocmd BufRead,BufNewFile bash_exports.local set filetype=sh
    autocmd BufRead,BufNewFile *.screen set filetype=screen
    autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
    autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
    autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                       Customed Features
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip tailing whitespace (\ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (\W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatically close brackets
" inoremap " ""<left>
" inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                       Local Configuration
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif