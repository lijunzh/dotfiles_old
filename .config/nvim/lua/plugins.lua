return require('packer').startup(function()

	-- Packer can manage itself as an optional plugin
	use {'wbthomason/packer.nvim', opt = true}

	-- Config
	use {
		'dstein64/vim-startuptime',
		cmd = 'StartupTime',
		config = [[vim.g.startuptime_tries = 10]]
	}

	-- Development
	use {'tpope/vim-fugitive'}
	use {'tpope/vim-vinegar'}
	use {'tpope/vim-commentary'}
	use {'nvim-lua/plenary.nvim'}
	use {
		'TimUntersberger/neogit',
		config = function()
			require('neogit').setup {integrations = {diffview = true}}
		end,
		requires = 'nvim-lua/plenary.nvim'
	}

	-- Color scheme
	use {'kyazdani42/nvim-web-devicons'}
	use {'sainnhe/gruvbox-material'}
	use {'tomasiser/vim-code-dark'}
	use {'phanviet/vim-monokai-pro'}
	use {'NLKNguyen/papercolor-theme'}

	-- Telescope
	use {'nvim-lua/popup.nvim'}
	use {'nvim-telescope/telescope.nvim'}
	use {
		'nvim-telescope/telescope-frecency.nvim',
		requires = {'tami5/sql.nvim'},
		config = function()
			require('telescope').load_extension('frecency')
		end
	}
	use {'nvim-telescope/telescope-symbols.nvim'}
	use {'nvim-telescope/telescope-github.nvim'}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

	-- LSP config
	use {'neovim/nvim-lspconfig'}

	-- Better LSP experience
	use {'glepnir/lspsaga.nvim'}
	use {'onsails/lspkind-nvim'}
	use {'sbdchd/neoformat'}
	use {'p00f/nvim-ts-rainbow'}
	use {'ray-x/lsp_signature.nvim'}
	use {'szw/vim-maximizer'}
	use {'dyng/ctrlsf.vim'}
	use {'dbeniamine/cheat.sh-vim'}
	use {'pechorin/any-jump.vim'}
	use {'kshenoy/vim-signature'}
	use {'kevinhwang91/nvim-bqf'}
	use {
	"folke/trouble.nvim",
	config = function() require("trouble").setup {} end
	}

	-- Completion
	use {'hrsh7th/nvim-compe'}
	use {'tzachar/compe-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-compe'}

	-- Snippets
	use {'hrsh7th/vim-vsnip'}

	-- Better syntax
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use {'nvim-treesitter/nvim-treesitter-textobjects'}


	-- Dashboard
	-- use {'glepnir/dashboard-nvim'}

	-- Status line
	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
		config = function() require 'statusline' end,
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

end)

