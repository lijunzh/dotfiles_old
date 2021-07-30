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

        -- Packer can manage itself as an optional plugin
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter",
        }

        -- color scheme and theme
        use {"sainnhe/gruvbox-material"}
        use {
            "kyazdani42/nvim-web-devicons",
            after = "gruvbox-material",
            config = function()
                require("configs.icons")
            end,

        }

        -- dashboard
        use {
            "glepnir/dashboard-nvim",
            cmd = {
                "Dashboard",
                "DashboardNewFile",
                "DashboardJumpMarks",
                "SessionLoad",
                "SessionSave"
            },
            setup = function()
                require "configs.dashboard"
            end
        }

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require "configs.nvimtree"
            end
        }

        -- status line
        use {
            "glepnir/galaxyline.nvim",
            after = "nvim-web-devicons",
            branch = "main",
            config = function()
                require("configs.statusline")
            end,
        }


        -- load autosave only if its globally enabled
        use {
            "Pocco81/AutoSave.nvim",
            config = function()
                require "configs.autosave"
            end,
            cond = function()
                return vim.g.auto_save == true
            end
        }

        -- startup time
        use {
            "dstein64/vim-startuptime",
            cmd = "StartupTime",
            config = "vim.g.startuptime_tries = 10"
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

        -- zen mode
        use {
            "Pocco81/TrueZen.nvim",
            cmd = {
                "TZAtaraxis",
                "TZMinimalist",
                "TZFocus"
            },
            config = function()
                require "configs.zenmode"
            end
        }

        -- color highlighter
        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("configs.others").colorizer()
            end
        }

        -- file navigator
        use {"tpope/vim-vinegar"}

        -- lua version of commentary
        use {
            "terrortylor/nvim-comment",
            event = "BufRead",
            config = function()
                require("configs.others").comment()
            end
        }

        -- lua version of autopairs
        use {
            "windwp/nvim-autopairs",
            -- after = "nvim-compe",
            event = 'InsertCharPre',
            after = 'nvim-lspconfig',
            config = function()
                require "configs.autopairs"
            end
        }

        -- highlight/move on matching text
        use {
            "andymass/vim-matchup",
            event = "CursorMoved"
        }

        -- Development
        use {
            "tpope/vim-fugitive",
            cmd = {
                "Git"
            }
        }
        use {
            "nvim-lua/plenary.nvim",
            event = "BufRead",
        }
        use {
            "nvim-lua/popup.nvim",
            after = "plenary.nvim",
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
                "ARSync"
            }
        }

        -- telescope
        use {
            "nvim-telescope/telescope.nvim",
            -- cmd = "Telescope",
        }
        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            -- cmd = "Telescope"
        }
        use {
            "nvim-telescope/telescope-media-files.nvim",
            -- cmd = "Telescope"
        }

        -- LSP config
        use {
            "kabouzeid/nvim-lspinstall",
            event = "BufRead",
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
                require "configs.lspconfig"
            end
        }
        use {
            "sbdchd/neoformat",
            event = "BufRead",
        }

        -- Completion
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("configs.compe")
            end,
            wants = "LuaSnip",
        }
        use {
            "tzachar/compe-tabnine",
            after = "nvim-compe",
            run="./install.sh",
            requires = "hrsh7th/nvim-compe"
        }

        -- Snippets
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

        -- Better syntax
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            run = ":TSUpdate",
            config = function()
                require("configs.treesitter")
            end,
        }
        -- TODO: Somehow, this plugin does not have effect for now.
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
    end
)
