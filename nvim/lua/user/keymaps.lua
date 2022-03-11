local keymap = require 'lib.utils'.keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('', 'gf', ':edit <cfile><CR>')

keymap('n', '<leader>vr', ':source ~/.config/nvim/init.lua<CR>')
keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>')

keymap('n', '<leader>jj', ']b')
keymap('n', '<leader>kk', '[b')

keymap('n', '<leader>K', ':nohlsearch<CR>')
keymap('n', '<leader>Q', ':bufdo bdelete<CR>')
keymap('n', '<leader>w', ':w<CR>')

keymap('v', 'y', 'myy`y')
keymap('v', 'Y', 'myY`y')

keymap('n', 'q:', ':q<CR>')

keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<LEFT><LEFT><LEFT>')
