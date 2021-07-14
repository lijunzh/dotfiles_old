local utils = require('utils')

utils.map('n', '<Leader>gs', '<cmd>Git<CR>')
utils.map('n', '<Leader>ga', '<cmd>Git add %<CR>')
utils.map('n', '<Leader>gc', '<cmd>Git commit<CR>')
utils.map('n', '<Leader>gp', '<cmd>Git push<CR>')
utils.map('n', '<Leader>gb', '<cmd>GBranches<CR>')
utils.map('n', '<Leader>gd', '<cmd>Gvdiffsplit<CR>')
utils.map('n', '<Leader>gf', '<cmd>Git fetch --all<CR>')
