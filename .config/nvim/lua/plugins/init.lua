local plugin_settings = require("core.utils").load_config().plugins
local present, packer = pcall(require, plugin_settings.options.packer.init_file)

if not present then
    return false
end

local override_req = require("core.utils").override_req

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
        config = override_req("nvim_web_devicons", "plugins.configs.icons", "setup"),
    },

    {
        "feline-nvim/feline.nvim",
        disable = not plugin_settings.status.feline,
        after = "nvim-web-devicons",
        config = override_req("feline", "plugins.configs.statusline", "setup"),
    },

    -- file navigator
    {"tpope/vim-vinegar"},

    -- autosave (on focus lost only)
    {
        "Pocco81/AutoSave.nvim",
        config = override_req("autosave", "plugins.configs.others", "autosave"),
        cond = vim.g.auto_save,
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
        "numToStr/Comment.nvim",
        disable = not plugin_settings.status.comment,
        module = "Comment",
        keys = { "gcc" },
        config = override_req("nvim_comment", "plugins.configs.others", "comment"),
        setup = function()
            require("core.mappings").comment()
        end,
    },

    ------------------------------------------------------------------------
    -- lsp
    ------------------------------------------------------------------------

    {
        "neovim/nvim-lspconfig",
        module = "lspconfig",
        opt = true,
        setup = function()
            require("core.utils").packer_lazy_load("nvim-lspconfig")
            -- reload the current file so lsp actually starts for it
            vim.defer_fn(function()
                vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
            end, 0)
        end,
        config = override_req("lspconfig", "plugins.configs.lspconfig"),
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
        disable = not plugin_settings.status.lspsignature,
        after = "nvim-lspconfig",
    },

    {
        "ray-x/lsp_signature.nvim",
        disable = not plugin_settings.status.lspsignature,
        after = "nvim-lspconfig",
        config = override_req("signature", "plugins.configs.others", "signature"),
    },

    {
        "andymass/vim-matchup",
        disable = not plugin_settings.status.vim_matchup,
        opt = true,
        setup = function()
            require("core.utils").packer_lazy_load("vim-matchup")
        end,
    },

    -- misc plugins
    {
        "windwp/nvim-autopairs",
        disable = not plugin_settings.status.autopairs,
        after = plugin_settings.options.autopairs.loadAfter,
        config = override_req("nvim_autopairs", "plugins.configs.others", "autopairs"),
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
        module = "cmp_nvim_lsp",
        disable = not plugin_settings.status.cmp,
        event = "InsertCharPre",
    },

    {
        "hrsh7th/nvim-cmp",
        disable = not plugin_settings.status.cmp,
        after = "friendly-snippets",
        config = override_req("nvim_cmp", "plugins.configs.cmp", "setup"),
    },

    {
        "L3MON4D3/LuaSnip",
        disable = not plugin_settings.status.cmp,
        wants = "friendly-snippets",
        after = "nvim-cmp",
        config = override_req("luasnip", "plugins.configs.others", "luasnip"),
    },

    {
        "saadparwaiz1/cmp_luasnip",
        disable = not plugin_settings.status.cmp,
        after = plugin_settings.options.cmp.lazy_load and "LuaSnip",
    },

    {
        "hrsh7th/cmp-nvim-lua",
        disable = not plugin_settings.status.cmp,
        after = "cmp_luasnip",
    },

    {
        "hrsh7th/cmp-nvim-lsp",
        disable = not plugin_settings.status.cmp,
        after = "cmp-nvim-lua",
    },

    {
        "hrsh7th/cmp-buffer",
        disable = not plugin_settings.status.cmp,
        after = "cmp-nvim-lsp",
    },

    {
        "hrsh7th/cmp-path",
        disable = not plugin_settings.status.cmp,
        after = "cmp-buffer",
    },

    {
        "hrsh7th/cmp-cmdline",
        disable = not plugin_settings.status.cmp,
        after = "cmp-path",
    },

    -- AI tools
    {
        "tzachar/cmp-tabnine",
        after = "nvim-cmp",
        run="./install.sh",
        requires = "hrsh7th/nvim-cmp",
        config = override_req("tabnine", "plugins.configs.others", "tabnine"),
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
        config = override_req("nvim_treesitter", "plugins.configs.treesitter", "setup"),
    },
    {
        "p00f/nvim-ts-rainbow",
        event = "BufRead",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufRead",
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "BufRead",
    },

    ------------------------------------------------------------------------
    -- fuzzy finder
    ------------------------------------------------------------------------

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
    -- git
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
        disable = not plugin_settings.status.gitsigns,
        opt = true,
        config = override_req("gitsigns", "plugins.configs.others", "gitsigns"),
        setup = function()
            require("core.utils").packer_lazy_load("gitsigns.nvim")
        end,
   },


    ------------------------------------------------------------------------
    -- utils
    ------------------------------------------------------------------------

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
}

-- return packer.startup { plugins }

--label plugins for operational assistance
plugins = require("core.utils").label_plugins(plugins)
--remove plugins specified in chadrc
plugins = require("core.utils").remove_default_plugins(plugins)
--add plugins specified in chadrc
plugins = require("core.utils").add_user_plugins(plugins)

return packer.startup(function(use)
   for _, v in pairs(plugins) do
      use(v)
   end
end)
