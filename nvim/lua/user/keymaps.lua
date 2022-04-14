local keymap = require 'lib.utils'.keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('', 'gf', ':edit <cfile><CR>')

keymap('n', '<leader>vr', ':source ~/.config/nvim/init.lua<CR>')
keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>')

keymap('n', '<leader>jj', ':bnext<CR>')
keymap('n', '<leader>kk', ':bprevious<CR>')
keymap('n', '<A-j>', ':bnext<CR>')
keymap('n', '<A-k>', ':bprevious<CR>')
keymap('i', '<A-j>', '<ESC>:bnext<CR>')
keymap('i', '<A-k>', '<ESC>:bprevious<CR>')

keymap('n', '<leader>K', ':nohlsearch<CR>')
keymap('n', '<leader>Q', ':bufdo bdelete<CR>')
keymap('n', '<leader>w', ':w<CR>')

keymap('v', 'y', 'myy`y')
keymap('v', 'Y', 'myY`y')

keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<LEFT><LEFT><LEFT>')
