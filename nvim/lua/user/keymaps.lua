vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('', 'gf', ':edit <cfile><CR>')

vim.keymap.set('n', '<A-j>', ':bnext<CR>')
vim.keymap.set('n', '<A-k>', ':bprevious<CR>')
vim.keymap.set('i', '<A-j>', '<ESC>:bnext<CR>')
vim.keymap.set('i', '<A-k>', '<ESC>:bprevious<CR>')
vim.keymap.set('i', '<A-w>', '<ESC>:w<CR>')

vim.keymap.set('n', '<leader>K', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>')
vim.keymap.set('n', '<A-w>', ':w<CR>')

vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//gc<LEFT><LEFT><LEFT>')
