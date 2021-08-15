--------------------------------------------------------------------------------
--
-- Editing
--
--------------------------------------------------------------------------------

-- autosave
vim.g.auto_save = true

-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- general
vim.opt.hidden = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 250 -- update interval for gitsigns
vim.opt.timeoutlen = 400
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.backspace = "" -- use legacy vim backspace settings
vim.opt.history=1000
vim.opt.modeline = false
vim.opt.foldenable = false -- speed up startup time

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>hl")

-- file change (autoread on change + notification on change)
vim.opt.undofile = true
vim.opt.backupskip = "/tmp/*,/private/tmp/*"
vim.opt.autoread = true

-- compe prerequisite
vim.opt.completeopt = "menuone,noselect"

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------

-- general
vim.opt.termguicolors = true
vim.opt.ruler = false
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.showmatch = true
vim.opt.wildmode = "longest,list,full"
vim.opt.title = true

-- have some line above and below cursor
vim.opt.scrolloff = 8

-- comment font
vim.cmd("highlight Comment cterm=italic gui=italic")

-- disable nvim intro
vim.opt.shortmess:append("sI")

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
vim.cmd("let &fcs='eob: '")

-- highlight on yank
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

-- line number
vim.opt.number = true
vim.opt.numberwidth = 2

-- line wrap
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showbreak = "↪"

-- list
vim.opt.list = true
vim.opt.listchars = 'tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮,space:·'

-- 79 column line
-- excpetions for git and text file are defined in utils.lua
vim.opt.textwidth = 79
vim.opt.colorcolumn = "+1"

-- highlight cursor line
vim.opt.cursorline = true

--------------------------------------------------------------------------------
-- Indentation
--------------------------------------------------------------------------------

-- default indent width
local indent = 2

-- indent default to tab
vim.opt.expandtab = false
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.smartindent = true

-- file extension specific tabbing
vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
vim.cmd([[autocmd Filetype lua setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])

--------------------------------------------------------------------------------
-- Disable builtin vim plugins
--------------------------------------------------------------------------------
local disabled_built_ins = {
    -- "netrw",
    -- "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
