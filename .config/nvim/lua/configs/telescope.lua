local present, telescope = pcall(require, "telescope")
if not present then
	return
end


telescope.setup {
	find_command = {
		'rg',
		'--no-heading',
		'--with-filename',
		'--line-number',
		'--column',
		'--smart-case'
	},
	use_less = true,
	file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
	grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
	qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
	extensions = {
		arecibo = {
			["selected_engine"] = 'google',
			["url_open_command"] = 'open',
			["show_http_headers"] = false,
			["show_domain_icons"] = false
		},
		fzf = {
			override_generic_sorter = false,
			override_file_sorter = true,
			case_mode = "smart_case"
		}
	}
}

if
	not pcall(
		function()
			telescope.load_extension("fzf")
			telescope.load_extension("gh")
			telescope.load_extension("frecency")
		end
	)
 then
	-- This should only trigger when in need of PackerSync, so better do it
	print("After completion of PackerSync, restart neovim.")
	-- Trigger packer compile on PackerComplete, so it properly waits for PackerSync
	vim.cmd 'autocmd User PackerComplete ++once lua require("packer").compile()'
	require "plugins"
	require("packer").sync("telescope-fzf-native.nvim", "telescope-github.nvim", "telescope-frecency")
end

