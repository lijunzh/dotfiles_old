local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.options = {

}

M.ui = {
    italic_comments = true,
    theme = "gruvbox",
}

-- these are plugin related options
M.plugins = {
   -- enable and disable plugins (false for disable)
   status = {
      blankline = true, -- show code scope with symbols
      bufferline = true, -- list open buffers up the top, easy switching too
      colorizer = false, -- color RGB, HEX, CSS, NAME color codes
      comment = true, -- easily (un)comment code, language aware
      dashboard = false, -- NeoVim 'home screen' on open
      esc_insertmode = true, -- map to <ESC> with no lag
      feline = true, -- statusline
      gitsigns = true, -- gitsigns in statusline
      lspsignature = true, -- lsp enhancements
      telescope_media = false, -- media previews within telescope finders
      vim_matchup = true, -- % operator enhancements
      cmp = true,
      nvimtree = true,
      autopairs = true,
   },
   options = {
      lspconfig = {
         setup_lspconf = "", -- path of file containing setups of different lsps
      },
      nvimtree = {
         enable_git = 0,
      },
      luasnip = {
         snippet_path = {},
      },
      statusline = { -- statusline related options
         -- these are filetypes, not pattern matched
         -- shown filetypes will overrule hidden filetypes
         hidden = {
            "help",
            "dashboard",
            "NvimTree",
            "terminal",
         },
         -- show short statusline on small screens
         shortline = true,
         shown = {},
         -- default, round , slant , block , arrow
         style = "default",
      },
      esc_insertmode_timeout = 300,
   },
   default_plugin_config_replace = {},
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

M.mappings.plugins = {
    -- file explorer/tree
    nvimtree = {
        toggle = "<C-n>",
        focus = "<leader>e",
    },
}

return M
