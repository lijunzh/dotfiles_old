local utils = require("core.utils")

local config = utils.load_config()
local map_wrapper = utils.map

local maps = config.mappings
local plugin_maps = maps.plugins

-- This is a wrapper function made to disable a plugin mapping from chadrc
-- If keys are nil, false or empty string, then the mapping will be not applied
-- Useful when one wants to use that keymap for any other purpose
local map = function(...)
   local keys = select(2, ...)
   if not keys or keys == "" then
      return
   end
   map_wrapper(...)
end

local M = {}

-- these mapping are only called during initialization
M.misc = function()
    local function non_configurable_mappsing()
        -- Don't copy the replaced text after pasting in visual mode
        map_wrapper("v", "p", '"_dP')

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        map_wrapper("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
        map_wrapper("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
        map_wrapper("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
        map_wrapper("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

        -- use ESC to turn off search highlighting
        map_wrapper("n", "<Esc>", ":noh <CR>")

        -- toggle list
        map_wrapper("n", "<Leader>l", "<Cmd>set nolist!<CR>")
    end

    local function configurable_mappings()
        -- buffer mappings --
        map("n", maps.misc.new_buffer, ":enew <CR>") -- new buffer
        map("n", maps.misc.new_tab, ":tabnew <CR>") -- new tabs
        map("n", maps.misc.save_file, ":w <CR>") -- save buffer to file
        map("n", maps.misc.update_file, ":update <CR>") -- save buffer if updated
        map("n", maps.misc.close_window, ":q <CR>") -- close current window but leave buffer on
        map("n", maps.misc.close_buffer, ":lua require('core.utils').close_buffer() <CR>") -- close buffer

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
end

-- below are all plugin related mappings

M.lspconfig = function()
    local m = plugin_maps.lspconfig

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", m.declaration, "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", m.definition, "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", m.hover, "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", m.implementation, "<cmd>lua vim.lsp.buf.implementation()<CR>")
    map("n", m.signature_help, "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    map("n", m.add_workspace_folder, "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
    map("n", m.remove_workspace_folder, "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
    map("n", m.list_workspace_folders, "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
    map("n", m.type_definition, "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    map("n", m.rename, "<cmd>lua vim.lsp.buf.rename()<CR>")
    map("n", m.code_action, "<cmd>lua vim.lsp.buf.code_action()<CR>")
    map("n", m.references, "<cmd>lua vim.lsp.buf.references()<CR>")
    map("n", m.float_diagnostics, "<cmd>lua vim.diagnostic.open_float()<CR>")
    map("n", m.goto_prev, "<cmd>lua vim.diagnostic.goto_prev()<CR>")
    map("n", m.goto_next, "<cmd>lua vim.diagnostic.goto_next()<CR>")
    map("n", m.set_loclist, "<cmd>lua vim.diagnostic.setloclist()<CR>")
    map("n", m.formatting, "<cmd>lua vim.lsp.buf.formatting()<CR>")
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
