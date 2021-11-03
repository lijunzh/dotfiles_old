local present, packer = pcall(require, "plugins.packer_init")

if not present then
    return false
end

local use = packer.use

return packer.startup(
    function()
        local status = require("core.utils").load_config().plugins.status

        ------------------------------------------------------------------------
        -- minimal plugins
        ------------------------------------------------------------------------
        -- Packer can manage itself as an optional plugin
        use {
            "nvim-lua/plenary.nvim",
        }
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter",
        }
        use {
            "nvim-lua/popup.nvim",
            after = "plenary.nvim",
        }

        ------------------------------------------------------------------------
        -- editor
        ------------------------------------------------------------------------
        -- color, icon, and status line
        use {"sainnhe/gruvbox-material"}
        use {
            "kyazdani42/nvim-web-devicons",
            after = "gruvbox-material",
            config = function()
                require("plugins.configs.icons")
            end,
        }
        use {
            "famiu/feline.nvim",
            disable = not status.feline,
            after = "nvim-web-devicons",
            config = function()
                require("plugins.configs.statusline")
            end,
        }

        -- file navigator
        use {"tpope/vim-vinegar"}
        use {
            "kyazdani42/nvim-tree.lua",
            disable = not status.nvimtree,
            cmd = { "NvimTreeToggle", "NvimTreeFocus" },
            config = function()
                require("core.mappings").nvimtree()
            end
        }

        -- autosave (on focus lost only)
        use {
            "Pocco81/AutoSave.nvim",
            config = function()
                require "plugins.configs.autosave"
            end,
            cond = function()
                return vim.g.auto_save == true
            end
        }

        -- smooth scroll
        use {
            "karb94/neoscroll.nvim",
            event = "WinScrolled",
            config = function()
                require("plugins.configs.others").neoscroll()
            end
        }

        -- indent lines
        use {
            "Yggdroot/indentLine",
            event = "BufRead",
            setup = function()
                require("plugins.configs.others").indentline()
            end
        }

        -- comment
        use {
            "terrortylor/nvim-comment",
            -- event = "BufRead",
            config = function()
                require("plugins.configs.others").comment()
            end
        }

        ------------------------------------------------------------------------
        -- lsp
        ------------------------------------------------------------------------
        -- lsp config
        use {
            "kabouzeid/nvim-lspinstall",
        }
        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function()
                require("plugins.configs.lspconfig")
            end
        }
        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("plugins.configs.lspkind")
            end
        }
        -- lua version of autopairs
        use {
            "windwp/nvim-autopairs",
            disable = not status.autopairs,
            -- after = 'nvim-lspconfig',
            after = "nvim-cmp",
            config = function()
                require("plugins.configs.others").autopairs()
            end
        }
        use {
            "sbdchd/neoformat",
            event = "BufRead",
            config = function()
                require("core.mappings").neoformat()
            end
        }

        ------------------------------------------------------------------------
        -- completion
        ------------------------------------------------------------------------
        -- complete and snippet
        use {
            "rafamadriz/friendly-snippets",
            disable = not status.cmp,
            event = "InsertEnter",
        }

        use {
            "hrsh7th/nvim-cmp",
            disable = not status.cmp,
            after = "friendly-snippets",
            config = function()
                require("plugins.configs.cmp")
            end
        }

        use {
            "L3MON4D3/LuaSnip",
            wants = "friendly-snippets",
            after = "nvim-cmp",
            config = function()
                require("plugins.configs.others").luasnip()
            end
        }

        use {
            "saadparwaiz1/cmp_luasnip",
            disable = not status.cmp,
            after = "LuaSnip",
        }

        use {
            "hrsh7th/cmp-nvim-lua",
            disable = not status.cmp,
            after = "cmp_luasnip",
        }

        use {
            "hrsh7th/cmp-nvim-lsp",
            disable = not status.cmp,
            after = "cmp-nvim-lua",
        }

        use {
            "hrsh7th/cmp-buffer",
            disable = not status.cmp,
            after = "cmp-nvim-lsp",
        }

        use {
            "hrsh7th/cmp-path",
            disable = not status.cmp,
            after = "cmp-buffer",
        }

        -- AI tools
        use {
            "tzachar/cmp-tabnine",
            after = "nvim-cmp",
            run="./install.sh",
            requires = "hrsh7th/nvim-cmp",
            config = function()
                require("plugins.configs.tabnine")
            end
        }
        use {
            "github/copilot.vim",
        }

        ------------------------------------------------------------------------
        -- syntax
        ------------------------------------------------------------------------
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            run = ":TSUpdate",
            config = function()
                require("plugins.configs.treesitter")
            end,
        }
        use {
            "p00f/nvim-ts-rainbow",
            event = "BufRead",
        }
        use {
            "nvim-treesitter/nvim-treesitter-textobjects",
            event = "BufRead",
        }
        use {
            "romgrk/nvim-treesitter-context",
            event = "BufRead",
        }
        use {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "BufRead",
        }
        -- use {
        --     "ray-x/lsp_signature.nvim",
        --     event = "BufRead",
        -- }

        ------------------------------------------------------------------------
        -- fuzzy finder
        ------------------------------------------------------------------------
        -- use {
        --     "nvim-telescope/telescope.nvim",
        --     after = "popup.nvim",
        --     config = function()
        --         require "plugins.configs.telescope"
        --     end
        -- }
        -- use {
        --     "nvim-telescope/telescope-fzf-native.nvim",
        --     run = "make",
        --     after = "popup.nvim"
        -- }
        use {
            "junegunn/fzf",
            event = "VimEnter",
        }
        use {
            "junegunn/fzf.vim",
            event = "VimEnter",
        }

        ------------------------------------------------------------------------
        -- utils
        ------------------------------------------------------------------------
        use {
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
            }
        }
        use {
            "lewis6991/gitsigns.nvim",
            after = "plenary.nvim",
            config = function()
                require("plugins.configs.gitsigns")
            end
        }
        use {
            "folke/which-key.nvim",
            config = function() require("which-key").setup {} end
        }
        use {
            "KenN7/vim-arsync",
            cmd = {
                "ARsyncUp", "ARsyncConf", "ARsyncDown", "ARsyncUpDelete",
            }
        }
        use {
            "dstein64/vim-startuptime",
            cmd = "StartupTime"
        }

    end
)
