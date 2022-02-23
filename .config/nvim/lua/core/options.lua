local options = require("core.utils").load_config().options
--------------------------------------------------------------------------------
--
-- Editing
--
--------------------------------------------------------------------------------

-- autosave
vim.g.auto_save = true

-- Map leader to space
vim.g.mapleader = options.mapleader
vim.g.maplocalleader = options.maplocalleader

-- general
vim.opt.hidden = options.hidden
vim.opt.ignorecase = options.ignorecase
vim.opt.smartcase = options.smartcase
vim.opt.splitbelow = options.splitbelow
vim.opt.splitright = options.splitright
vim.opt.updatetime = options.updatetime 
vim.opt.timeoutlen = options.timeoutlen
vim.opt.clipboard = options.clipboard
vim.opt.mouse = options.mouse
vim.opt.backspace = options.backspace
vim.opt.history=options.history
vim.opt.modeline = options.modeline
vim.opt.foldenable = options.foldenable

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>hl")

-- file change (autoread on change + notification on change)
vim.opt.undofile = options.undofile
vim.opt.backupskip = options.backupskip
vim.opt.autoread = options.autoread

-- compe prerequisite
vim.opt.completeopt = "menuone,noselect"

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------

-- general
vim.opt.termguicolors = options.termguicolors
vim.opt.ruler = options.ruler
vim.opt.signcolumn = options.signcolumn
vim.opt.cmdheight = options.cmdheight
vim.opt.showmatch = options.showmatch
vim.opt.wildmode = options.wildmode
vim.opt.title = options.title

-- have some line above and below cursor
vim.opt.scrolloff = options.scrolloff

-- comment font
vim.cmd("highlight Comment cterm=italic gui=italic")

-- disable nvim intro
vim.opt.shortmess:append("sI")

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
vim.cmd("let &fcs='eob: '")

-- highlight on yank
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

-- line number
vim.opt.number = options.number
vim.opt.numberwidth = options.numberwidth

-- line wrap
vim.opt.wrap = options.wrap
vim.opt.linebreak = options.linebreak
vim.opt.showbreak = options.showbreak

-- list
vim.opt.list = options.list
vim.opt.listchars = options.listchars

-- 79 column line
-- excpetions for git and text file are defined in utils.lua
vim.opt.textwidth = options.textwidth
vim.opt.colorcolumn = options.colorcolumn

-- highlight cursor line
vim.opt.cursorline = options.cursorline

--------------------------------------------------------------------------------
-- Indentation
--------------------------------------------------------------------------------

-- default indent width
-- indent default to tab
vim.opt.expandtab = options.expandtab
vim.opt.shiftwidth = options.indent
vim.opt.tabstop = options.indent
vim.opt.softtabstop = options.indent
vim.opt.smartindent = options.smartindent

-- file extension specific tabbing
vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
vim.cmd([[autocmd Filetype lua setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])

--------------------------------------------------------------------------------
-- Disable builtin vim plugins
--------------------------------------------------------------------------------
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
