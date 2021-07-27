local function map(mode, lhs, rhs, opts)
	local options = {noremap = true, silent = true}
	if opts then
	options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- Save file
map('n', '<Leader>s', '<Cmd>update<CR>')
map('n', '<Leader>q', '<Cmd>q<CR>')
map('n', '<Leader>w', '<Cmd>w<CR>')
map('n', '<Leader>v', '<Cmd>Reload<CR>')
map('n', '<Leader>f', '<Cmd>Neoformat<CR>')

-- navigate file in vertical split:
vim.cmd('nnoremap <silent> vg] :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>')
vim.cmd('nnoremap <silent> vgf :vertical botright wincmd f<CR>')

-- Packer commands till because we are not loading it at startup
vim.cmd("silent! command PackerCompile lua require 'plugin_list' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'plugin_list' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'plugin_list' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugin_list' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'plugin_list' require('packer').update()")
