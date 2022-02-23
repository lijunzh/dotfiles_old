local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.options = {
    autoread = true,
    backupskip = "/tmp/*,/private/tmp/*",
    backspace = "",             -- legacy vim backspace settings
    clipboard = "unnamedplus",
    cmdheight = 1,
    colorcolumn = "+1",
    cursorline = true,
    expandtab = true,
    foldenable = false,         -- speed up startup time
    hidden = true,
    history = 1000,
    indent = 2,
    ignorecase = true,
    linebreak = true,
    list = true,
    listchars = 'tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮,space:·',
    mapleader = " ",
    maplocalleader = ",",
    modeline = false,
    mouse = "a",
    number = true,
    numberwidth = 2,
    ruler = false,
    scrolloff = 8,
    showbreak = "↪",
    showmatch = true,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    termguicolors = true,
    textwidth = 79,
    timeoutlen = 400,
    title = true,
    undofile = true,
    updatetime = 250,           -- update interval for gitsigns
    wildmode = "longest,list,full",
    wrap = false,
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
        packer = {
            init_file = "plugins.packer_init",
        },
        autopairs = { loadAfter = "nvim-cmp" },
        cmp = {
            lazy_load = true,
        },
        lspconfig = {
            setup_lspconf = "", -- path of file containing setups of different lsps
        },
       nvimtree = {
            lazy_load = ture,
       },
       luasnip = {
            snippet_path = {},
       },
       statusline = { -- statusline related options
          -- these are filetypes, not pattern matched
          -- shown filetypes will overrule hidden filetypes
            hidden = {
                "help",
                "NvimTree",
                "terminal",
                "alpha"
            },
            shown = {},
            -- show short statusline on small screens
            shortline = true,
            -- default, round , slant , block , arrow
            style = "default",
       },
       esc_insertmode_timeout = 300,
    },
    default_plugin_config_replace = {},
    default_plugins_remove = {},
    install = nil,
}

M.mappings = {

    misc = {
        -- buffer mappings --
        new_buffer = "<leader>n", -- open a new buffer
        new_tab = "<leader>t", -- open a new vim tab
        save_file = "<leader>w", -- save file using :w
        update_file = "<leader>s", -- save file if updated
        close_window = "<leader>q",
        close_buffer = "<leader>x",
    },

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

M.mappings.plugin = {
    -- lsp bindings
    lspconfig = {
        declaration = "gD",
        definition = "gd",
        hover = "K",
        implementation = "gi",
        signature_help = "gk",
        add_workspace_folder = "<leader>wa",
        remove_workspace_folder = "<leader>wr",
        list_workspace_folders = "<leader>wl",
        type_definition = "<leader>D",
        rename = "<leader>rn",
        code_action = "<leader>ca",
        references = "gr",
        float_diagnostics = "ge",
        goto_prev = "[d",
        goto_next = "]d",
        set_loclist = "<leader>q",
        formatting = "<leader>lfm",
    },

    -- file explorer/tree
    nvimtree = {
        toggle = "<C-n>",
        focus = "<leader>e",
    },
}

return M
