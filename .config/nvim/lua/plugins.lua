local present, _ = pcall(require, "packer_init")
local packer

if present then
    packer = require "packer"
else
    return false
end

local use = packer.use

return packer.startup(
    function()

        ------------------------------------------------------------------------
        -- minimal plugins
        ------------------------------------------------------------------------
        -- Packer can manage itself as an optional plugin
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter",
        }
        use {
            "nvim-lua/plenary.nvim",
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
                require("configs.icons")
            end,
        }
        use {
            "glepnir/galaxyline.nvim",
            after = "nvim-web-devicons",
            branch = "main",
            config = function()
                require("configs.statusline")
            end,
        }

        -- file navigator
        use {"tpope/vim-vinegar"}
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require "configs.nvimtree"
            end
        }

        -- autosave (on focus lost only)
        use {
            "Pocco81/AutoSave.nvim",
            config = function()
                require "configs.autosave"
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
                require("configs.others").neoscroll()
            end
        }

        -- indent lines
        use {
            "Yggdroot/indentLine",
            event = "BufRead",
            setup = function()
                require("configs.others").indentline()
            end
        }

        -- comment
        use {
            "terrortylor/nvim-comment",
            -- event = "BufRead",
            config = function()
                require("configs.others").comment()
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
                require("configs.lspconfig")
            end
        }
        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require "configs.lspkind"
            end
        }
        -- lua version of autopairs
        use {
            "windwp/nvim-autopairs",
            event = 'InsertCharPre',
            after = 'nvim-lspconfig',
            config = function()
                require "configs.autopairs"
            end
        }
        use {
            "sbdchd/neoformat",
            event = "BufRead",
        }

        ------------------------------------------------------------------------
        -- completion
        ------------------------------------------------------------------------
        -- complete engine
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("configs.compe")
            end,
            wants = "LuaSnip",
        }

        -- AI tools
        use {
            "tzachar/compe-tabnine",
            after = "nvim-compe",
            run="./install.sh",
            requires = "hrsh7th/nvim-compe"
        }

        -- snippets
        use {
            "L3MON4D3/LuaSnip",
            after = "nvim-compe",
            wants = "friendly-snippets",
            config = function()
                require "configs.luasnip"
            end
        }
        use {
            "rafamadriz/friendly-snippets",
            event = "InsertEnter",
        }

        ------------------------------------------------------------------------
        -- syntax
        ------------------------------------------------------------------------
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            run = ":TSUpdate",
            config = function()
                require("configs.treesitter")
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
            config = function()
                require("treesitter-context.config").setup {enable = true}
            end
        }
        use {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "BufRead",
        }
        use {
            "ray-x/lsp_signature.nvim",
            event = "BufRead",
        }

        ------------------------------------------------------------------------
        -- fuzzy finder
        ------------------------------------------------------------------------
        -- use {
        --     "nvim-telescope/telescope.nvim",
        --     after = "popup.nvim",
        --     config = function()
        --         require "configs.telescope"
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
                require("configs.gitsigns")
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
