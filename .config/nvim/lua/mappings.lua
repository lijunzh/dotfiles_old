local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
    options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- save file
map("n", "<Leader>s", "<Cmd>update<CR>", opt)
map("n", "<Leader>q", "<Cmd>q<CR>", opt)
map("n", "<Leader>w", "<Cmd>w<CR>", opt)

-- don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP', opt)

-- copy whole file content
map("n", "<C-a>", ":%y+<CR>", opt)

-- navigate file in vertical split:
vim.cmd("nnoremap <silent> <Leader>] :let word=expand('<cword>')<CR>:vsp<CR>:wincmd w<cr>:exec('tag '. word)<cr>")
vim.cmd("nnoremap <silent> <Leader>f :vertical botright wincmd f<CR>")

-- terminals
map("n", "<C-l>", ":vnew +terminal | setlocal nobuflisted <CR>", opt) -- term over right
map("n", "<C-x>", ":10new +terminal | setlocal nobuflisted <CR>", opt) --  term bottom
map("n", "<C-t>t", ":terminal <CR>", opt) -- term buffer

-- get out of terminal with jk
map("t", "jk", "<C-\\><C-n>", opt)

-- Packer commands till because we are not loading it at startup
vim.cmd("silent! command PackerCompile lua require 'plugins' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'plugins' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'plugins' require('packer').update()")

-- compe stuff
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs
    if
        not pcall(
            function()
                npairs = require "nvim-autopairs"
            end
        )
     then
        return
    end

    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

-- compe mappings
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- nvimtree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)

-- format code
map("n", "<Leader>fm", "<Cmd>Neoformat<CR>")

-- git (fugitive)
map("n", "<Leader>gs", ":Git<CR>", opt)
map("n", "<Leader>ga", ":Git add %<CR>", opt)
map("n", "<Leader>gc", ":Git commit<CR>", opt)
map("n", "<Leader>gp", ":Git push<CR>", opt)
map("n", "<Leader>gb", ":GBranches<CR>", opt)
map("n", "<Leader>gd", ":Gvdiffsplit<CR>", opt)
map("n", "<Leader>gf", ":Git fetch --all<CR>", opt)

-- toggle list
map("n", "<Leader>l", "<Cmd>set nolist!<CR>")

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>", opt)

-- -- telescope
-- map("n", "<Leader>fw", ":Telescope live_grep<CR>", opt)     -- find word
-- map("n", "<Leader>fd", ":Telescope git_status <CR>", opt)   -- find diff
-- map("n", "<Leader>fc", ":Telescope git_commits <CR>", opt)  -- find commit
-- map("n", "<Leader>ff", ":Telescope find_files <CR>", opt)   -- find file
-- map("n", "<Leader>fb", ":Telescope buffers<CR>", opt)       -- find buffer
-- map("n", "<Leader>fo", ":Telescope oldfiles<CR>", opt)      -- find old files

-- -- zenmode
-- map("n", "<leader>zz", ":TZAtaraxis<CR>", opt)
-- map("n", "<leader>zm", ":TZMinimalist<CR>", opt)
-- map("n", "<leader>zf", ":TZFocus<CR>", opt)

-- fzf
map("n", "<Leader>fw", ":Rg <CR>")
map("n", "<Leader>ff", ":Files <CR>")
map("n", "<Leader>fl", ":Lines <CR>")
map("n", "<Leader>fo", ":History <CR>")
map("n", "<Leader>fb", ":Buffers <CR>")
map("n", "<Leader>fd", ":GFiles? <CR>")
