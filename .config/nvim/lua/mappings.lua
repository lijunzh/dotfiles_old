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

-- Don't copy the replaced text after pasting in visual mode
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

-- Truezen.nvim
map("n", "<leader>zz", ":TZAtaraxis<CR>", opt)
map("n", "<leader>zm", ":TZMinimalist<CR>", opt)
map("n", "<leader>zf", ":TZFocus<CR>", opt)

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

-- dashboard stuff
map("n", "<Leader>db", ":Dashboard<CR>", opt)
map("n", "<Leader>fn", ":DashboardNewFile<CR>", opt)
map("n", "<Leader>bm", ":DashboardJumpMarks<CR>", opt)
map("n", "<C-s>l", ":SessionLoad<CR>", opt)
map("n", "<C-s>s", ":SessionSave<CR>", opt)

-- Telescope
map("n", "<Leader>fw", ":Telescope live_grep<CR>", opt)
map("n", "<Leader>gt", ":Telescope git_status <CR>", opt)
map("n", "<Leader>cm", ":Telescope git_commits <CR>", opt)
map("n", "<Leader>ff", ":Telescope find_files <CR>", opt)
map("n", "<Leader>fp", ":Telescope media_files <CR>", opt)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opt)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
map("n", "<Leader>fo", ":Telescope oldfiles<CR>", opt)

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

-- get out of terminal with jk
map("t", "jk", "<C-\\><C-n>", opt)
