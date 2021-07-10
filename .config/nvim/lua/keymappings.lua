local utils = require('utils')

utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('n', '<Leader>w', '<Cmd>update<CR>')
utils.map('n', '<Leader>q', '<Cmd>q<CR>')
utils.map('n', '<Leader>fw', '<Cmd>w<CR>')
