local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.options = {

}

M.ui = {
    italic_comments = true,
    theme = "gruvbox",
}

M.mappings = {
    -- buffer mappings --
    new_buffer = "<leader>n", -- open a new buffer
    new_tab = "<leader>t", -- open a new vim tab
    save_file = "<leader>w", -- save file using :w
    update_file = "<leader>s", -- save file if updated
    close_window = "<leader>q",
    close_buffer = "<leader>x",
    -- terminal mappings --
    terminal = {
        esc_termmode = { "jk", "esc" }, -- multiple mappings allowed
        -- below three are for spawning terminals
        new_horizontal = "<C-t>h",
        new_vertical = "<C-t>v",
        new_window = "<C-t>w",
    },
    packer = {
        clean = "<C-p>c",
        sync = "<C-p>s",
    },
}

return M
