local cmd = vim.cmd
local utils = require('utils')

-- Save file
utils.map('n', '<Leader>s', '<Cmd>update<CR>')
utils.map('n', '<Leader>q', '<Cmd>q<CR>')
utils.map('n', '<Leader>w', '<Cmd>w<CR>')
utils.map('n', '<Leader>v', '<Cmd>Reload<CR>')
utils.map('n', '<Leader>f', '<Cmd>Neoformat<CR>')

-- navigate file in vertical split:
cmd 'nnoremap <silent> vg] :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>'
cmd 'nnoremap <silent> vgf :vertical botright wincmd f<CR>'