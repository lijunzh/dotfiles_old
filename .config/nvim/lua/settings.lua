local utils = require('utils')

local fn = vim.fn
local cmd = vim.cmd
local o = vim.o
local wo = vim.wo
local bo = vim.bo

--------------------------------------------------------------------------------
--
-- Editing
--
--------------------------------------------------------------------------------
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'

-- file change (autoread on change + notification on change)
vim.api.nvim_exec([[
augroup file_change
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
	autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]], false)

-- indent default to tab
bo.expandtab = false
bo.tabstop = indent
bo.softtabstop = indent
bo.shiftwidth = indent
o.smarttab = true
o.shiftround = true

-- language specific tab settings
vim.api.nvim_exec([[
augroup vimTabLanguage
	autocmd!
	" python always use 4 spaces instead of 1 tab
	autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab ff=unix
	" markdown expand tab into spaces
	autocmd Filetype markdown setlocal ts=2 sts=2 sw=2 expandtab ff=unix
	" latex always use 2 space instead 1 tab
	autocmd Filetype tex setlocal ts=2 sts=2 sw=2 expandtab ff=unix
augroup END
]], false)


-- split bottom and right
o.splitright = true
o.splitbelow = true

-- do no add empty newline at the end of files
bo.binary = true
bo.eol = false

-- control settings
if fn.has('mouse') then o.mouse = 'a' end			-- mouse support
o.clipboard = 'unnamed'								-- use system clipboard
o.backspace = ''									-- use legacy vim backspace settings
o.smartcase = true									-- case-sensitive if expression contains a captial letter
cmd 'set complete+=kspell'							-- complete with dictionary words
cmd 'set path+=**'									-- add current directory to path

-- search highlight only when search
vim.api.nvim_exec([[
augroup search_highlighting
	autocmd!
	autocmd CmdlineEnter /,\? :set hlsearch
	autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]], false)

-- save all file on focus lost and remove tailing white space
vim.api.nvim_exec([[
augroup auto_save_remove_white_space
	autocmd!
	autocmd FocusLost * silent! wa
	autocmd BufWritePre * :%s/\s\+$//e
augroup END
]], false)
-- navigate file in vertical split:
--	<Leader>] to jump to tag in a vertical split
--	<Leader>f to jump to file in a vertical split
cmd 'nnoremap <silent> <Leader>] :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>'
cmd 'nnoremap <silent> <Leader>f :vertical botright wincmd f<CR>'

--------------------------------------------------------------------------------
--
-- Appearance
--
--------------------------------------------------------------------------------

o.termguicolors = true								-- color
o.scrolloff = 8										-- have some line above and below cursor
cmd 'highlight Comment cterm=italic gui=italic'		-- comment font
o.cmdheight = 2										-- make command window height of 2 rows
o.title = true										-- show title
o.showmatch = true									-- show matched brackets
o.wildmode = 'longest,list,full'					-- complete files like a sheel

-- line number
wo.number = true
vim.api.nvim_exec([[
augroup hybrid_line_number
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
]], false)

-- line wrap
wo.wrap = false
wo.linebreak = true
o.showbreak='…'

-- highlight on yank
cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'

-- 79 column line
bo.textwidth = 79
wo.colorcolumn = '+1'
vim.api.nvim_exec([[
augroup column_width
	autocmd!
	" no text wrap for text files
	autocmd Filetype tex,plaintex,markdown,text setlocal tw=0 wrap
	" 72 columns for git commit
	autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END
]], false)

-- hightlight cursor line
wo.cursorline = true
vim.api.nvim_exec([[
augroup cursor_line_current_window
	autocmd!
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END
]], false)


-- list
wo.list = true
o.listchars = 'tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮,space:·'
o.showbreak = '↪'

-- auto formating
vim.api.nvim_exec([[
augroup auto_fmt
	autocmd!
	autocmd BufWritePre *.py,*.lua try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
aug END
]], false)
