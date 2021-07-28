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

		-- status line
		use {
			"glepnir/galaxyline.nvim",
			branch = "main",
			config = function()
				require("configs.statusline")
			end,
			requires = {
				{
					"kyazdani42/nvim-web-devicons",
					config = function()
						require("configs.icons")
					end,
				},
			}
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

		-- indent blankline
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufRead",
			setup = function()
				require("configs.others").blankline()
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
            after = "nvim-compe",
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

		-- Color scheme
		use {"sainnhe/gruvbox-material"}
		-- use {"tomasiser/vim-code-dark"}
		-- use {"phanviet/vim-monokai-pro"}
		-- use {"NLKNguyen/papercolor-theme"}

		-- Telescope
		use {
			"jremmen/vim-ripgrep",
			cmd = "Telescope",
		}
		use {
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope",
		}
		use {
			"nvim-telescope/telescope-frecency.nvim",
			cmd = "Telescope",
			requires = {"tami5/sql.nvim"},
		}
		use {
			"nvim-telescope/telescope-github.nvim",
			cmd = "Telescope",
		}
		use {
			"nvim-telescope/telescope-fzf-native.nvim",
			cmd = "Telescope",
			run = "make",
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
		-- use {"ray-x/lsp_signature.nvim"}
		-- use {
		-- 	"folke/trouble.nvim",
		-- 	config = function() require("trouble").setup {} end
		-- }
		-- use {"simrat39/symbols-outline.nvim"}

		-- Completion
		use {
			"hrsh7th/nvim-compe",
			config = function()
				require("configs.compe")
			end,
		}
		use {
			"tzachar/compe-tabnine",
			run="./install.sh",
			requires = "hrsh7th/nvim-compe"
		}

		-- Snippets
		use {"hrsh7th/vim-vsnip"}
		use {"cstrap/python-snippets"}
		use {"ylcnfrht/vscode-python-snippet-pack"}

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
