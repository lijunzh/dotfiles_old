local utils = require("core.utils")
local hooks = require("core.hooks")
local config = require("core.default_config")

local map = utils.map
local maps = config.mappings

local M = {}

-- these mapping are only called during initialization
M.misc = function()
    local function non_configurable_mappsing()
        -- Don't copy the replaced text after pasting in visual mode
        map("v", "p", '"_dP')

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
        map("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
        map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
        map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

        -- use ESC to turn off search highlighting
        map("n", "<Esc>", ":noh <CR>")

        -- toggle list
        map("n", "<Leader>l", "<Cmd>set nolist!<CR>")
    end

    local function configurable_mappings()
        -- buffer mappings --
        map("n", maps.new_buffer, ":enew <CR>") -- new buffer
        map("n", maps.new_tab, ":tabnew <CR>") -- new tabs
        map("n", maps.save_file, ":w <CR>") -- save buffer to file
        map("n", maps.update_file, ":update <CR>") -- save buffer if updated
        map("n", maps.close_window, ":q <CR>") -- close current window but leave buffer on
        map("n", maps.close_buffer, ":lua require('core.utils').close_buffer() <CR>") -- close buffer

        -- terminal mappings --
        map("t", maps.terminal.esc_termmode, "<C-\\><C-n>")
        map("n", maps.terminal.new_horizontal, ":10new +terminal | setlocal nobuflisted <CR>")
        map("n", maps.terminal.new_vertical, ":vnew +terminal | setlocal nobuflisted <CR>")
        map("n", maps.terminal.new_window, ":terminal <CR>")

        -- packer mappings --
        map("n", maps.packer.clean, ":PackerClean <CR>")
        map("n", maps.packer.sync, ":PackerSync <CR>")
    end

    local function packer_mappings()
        -- Add Packer commands because we are not loading it at startup
        vim.cmd("silent! command PackerClean lua require 'plugins' require('packer').clean()")
        vim.cmd("silent! command PackerCompile lua require 'plugins' require('packer').compile()")
        vim.cmd("silent! command PackerInstall lua require 'plugins' require('packer').install()")
        vim.cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
        vim.cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
        vim.cmd("silent! command PackerUpdate lua require 'plugins' require('packer').update()")
    end

    packer_mappings()
    non_configurable_mappsing()
    configurable_mappings()
    hooks.run("setup_mappings", map)
end

-- plugin specific mappings

M.nvimtree = function()
    map("n", maps.plugin.nvimtree.toggle, ":NvimTreeToggle <CR>")
    map("n", maps.plugin.nvimtree.focus, ":NvimTreeFocus <CR>")
end

M.neoformat = function()
    map("n", "<leader>fm", ":Neoformat <CR>")
end

M.fzf = function()
    map("n", "<Leader>fw", ":Rg <CR>")
    map("n", "<Leader>ff", ":Files <CR>")
    map("n", "<Leader>fl", ":Lines <CR>")
    map("n", "<Leader>fo", ":History <CR>")
    map("n", "<Leader>fb", ":Buffers <CR>")
    map("n", "<Leader>fd", ":GFiles? <CR>")
end

return M
