local plugin_settings = require("core.utils").load_config().plugins
local present, packer = pcall(require, plugin_settings.options.packer.init_file)

if not present then
    return false
end

local plugins = {
    ------------------------------------------------------------------------
    -- basic plugins
    ------------------------------------------------------------------------
    { "nvim-lua/plenary.nvim", },

    -- speed up startup time
    { "lewis6991/impatient.nvim" },
    { "nathom/filetype.nvim" },

    -- Packer can manage itself as an optional plugin
    {
        "wbthomason/packer.nvim",
        event = "VimEnter",
    },

    ------------------------------------------------------------------------
    -- editor
    ------------------------------------------------------------------------
    -- color, icon, and status line
    {"sainnhe/gruvbox-material"},
    {
        "kyazdani42/nvim-web-devicons",
        after = "gruvbox-material",
        config = function()
            require("plugins.configs.icons")
        end,
    },
    {
        "feline-nvim/feline.nvim",
        after = "nvim-web-devicons",
        config = function()
            require("plugins.configs.statusline")
        end,
    },

    -- file navigator
    {"tpope/vim-vinegar"},

    -- autosave (on focus lost only)
    {
        "Pocco81/AutoSave.nvim",
        config = function()
            require "plugins.configs.autosave"
        end,
        cond = function()
            return vim.g.auto_save == true
        end
    },

    -- smooth scroll
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require("plugins.configs.others").neoscroll()
        end
    },

    -- indent lines
    {
        "Yggdroot/indentLine",
        event = "BufRead",
        setup = function()
            require("plugins.configs.others").indentline()
        end
    },

    -- comment
    {
        "terrortylor/nvim-comment",
        -- event = "BufRead",
        config = function()
            require("plugins.configs.others").comment()
        end
    },

    ------------------------------------------------------------------------
    -- lsp
    ------------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        opt = true,
        setup = function()
            require("core.utils").packer_lazy_load "nvim-lspconfig"
            -- reload the current file so lsp actually starts for it
            vim.defer_fn(function()
                vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
            end, 0)
        end,
        config = function()
            require("plugins.configs.lspconfig")
        end
    },

    {
        "williamboman/nvim-lsp-installer",
        event = "VimEnter",
        config = function()
            require("plugins.configs.lsp_installer")
        end,
    },

    {
        "onsails/lspkind-nvim",
        event = "VimEnter",
    },

    -- lua version of autopairs
    {
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function()
            require("plugins.configs.others").autopairs()
        end
    },

    {
        "sbdchd/neoformat",
        event = "BufRead",
        config = function()
            require("core.mappings").neoformat()
        end
    },

    ------------------------------------------------------------------------
    -- completion
    ------------------------------------------------------------------------
    -- complete and snippet
    {
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
    },

    {
        "hrsh7th/nvim-cmp",
        after = "friendly-snippets",
        config = function()
            require("plugins.configs.cmp")
        end
    },

    {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        after = "nvim-cmp",
        config = function()
            require("plugins.configs.others").luasnip()
        end
    },

    {
        "saadparwaiz1/cmp_luasnip",
        after = "LuaSnip",
    },

    {
        "hrsh7th/cmp-nvim-lua",
        after = "cmp_luasnip",
    },

    {
        "hrsh7th/cmp-nvim-lsp",
        after = "cmp-nvim-lua",
    },

    {
        "hrsh7th/cmp-buffer",
        after = "cmp-nvim-lsp",
    },

    {
        "hrsh7th/cmp-path",
        after = "cmp-buffer",
    },

    {
        "hrsh7th/cmp-cmdline",
        after = "cmp-path",
    },

    -- AI tools
    {
        "tzachar/cmp-tabnine",
        after = "nvim-cmp",
        run="./install.sh",
        requires = "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.configs.tabnine")
        end
    },
    {
        "github/copilot.vim",
    },

    ------------------------------------------------------------------------
    -- syntax
    ------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        run = ":TSUpdate",
        config = function()
            require("plugins.configs.treesitter")
        end,
    },
    {
        "p00f/nvim-ts-rainbow",
        event = "BufRead",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufRead",
    },
    -- {
    --     "romgrk/nvim-treesitter-context",
    --     event = "BufRead",
    -- },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "BufRead",
    },
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     event = "BufRead",
    -- },

    ------------------------------------------------------------------------
    -- fuzzy finder
    ------------------------------------------------------------------------
    -- {
    --     "nvim-telescope/telescope.nvim",
    --     after = "popup.nvim",
    --     config = function()
    --         require "plugins.configs.telescope"
    --     end
    -- },
    -- {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     run = "make",
    --     after = "popup.nvim"
    -- },
    {
        "junegunn/fzf",
        event = "VimEnter",
    },
    {
        "junegunn/fzf.vim",
        event = "VimEnter",
        config = function()
            require("core.mappings").fzf()
        end
    },

    ------------------------------------------------------------------------
    -- utils
    ------------------------------------------------------------------------
    {
        "tpope/vim-fugitive",
        cmd = {
            "Git",
            "GBranches",
            "Gvdiffsplit",
            "Gdiffsplit",
            "Gread",
            "Gwrite",
            "Ggrep",
            "GMove",
            "GRename",
            "GDelete",
            "GRemove",
            "GBrowse",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        after = "plenary.nvim",
        config = function()
            require("plugins.configs.gitsigns")
        end
    },
    {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end
    },
    {
        "KenN7/vim-arsync",
        cmd = {
            "ARsyncUp", "ARsyncConf", "ARsyncDown", "ARsyncUpDelete",
        },
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime"
    },

}

return packer.startup { plugins }
