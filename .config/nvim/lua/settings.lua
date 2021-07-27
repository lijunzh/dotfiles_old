local utils = require('utils')


--------------------------------------------------------------------------------
--
-- Editing
--
--------------------------------------------------------------------------------

-- speed up startup time
vim.opt.foldenable = false

-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local indent = 4

-- file change (autoread on change + notification on change)
vim.opt.undofile = true
vim.opt.autoread = true
vim.api.nvim_exec([[
augroup file_change
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
	autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]], false)

-- indent default to tab
vim.opt.expandtab = false
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth = indent
vim.opt.smarttab = true
vim.opt.shiftround = true

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
vim.opt.splitright = true
vim.opt.splitbelow = true

-- do no add empty newline at the end of files
vim.opt.binary = true
vim.opt.eol = false

-- control settings
if vim.fn.has('mouse') then vim.opt.mouse = 'a' end			-- mouse support
vim.opt.clipboard = 'unnamed'								-- use system clipboard
vim.opt.backspace = ''									-- use legacy vim backspace settings
vim.opt.smartcase = true									-- case-sensitive if expression contains a captial letter
vim.cmd('set complete+=kspell')							-- complete with dictionary words
vim.cmd('set path+=**')									-- add current directory to path

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

--------------------------------------------------------------------------------
--
-- Appearance
--
--------------------------------------------------------------------------------

vim.opt.termguicolors = true								-- color
vim.opt.scrolloff = 8										-- have some line above and below cursor
vim.opt.cmdheight = 2										-- make command window height of 2 rows
vim.opt.title = true										-- show title
vim.opt.showmatch = true									-- show matched brackets
vim.opt.wildmode = 'longest,list,full'					-- complete files like a sheel
vim.cmd 'highlight Comment cterm=italic gui=italic'		-- comment font

-- line number
vim.opt.number = true
vim.api.nvim_exec([[
augroup hybrid_line_number
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
]], false)

-- line wrap
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showbreak = '↪'

-- highlight on yank
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

-- 79 column line
vim.opt.textwidth = 79
vim.opt.colorcolumn = '+1'
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
vim.opt.cursorline = true
vim.api.nvim_exec([[
augroup cursor_line_current_window
	autocmd!
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
augroup END
]], false)


-- list
vim.opt.list = true
vim.opt.listchars = 'tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮,space:·'
