local terminal = require('user.terminal')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- useful
vim.keymap.set('', 'gf', '<CMD>edit <cfile><CR>')
vim.keymap.set('n', '<leader>K', '<CMD>nohlsearch<CR>')

vim.keymap.set('i', '<A-w>', '<ESC><CMD>w<CR>')
vim.keymap.set('n', '<A-w>', '<CMD>w<CR>')

vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('v', '<C-r>', '"hy<CMD>%s/<C-r>h//gc<LEFT><LEFT><LEFT>')

-- buffer navigation
vim.keymap.set('n', '<A-j>', '<CMD>bnext<CR>')
vim.keymap.set('n', '<A-k>', '<CMD>bprevious<CR>')
vim.keymap.set('i', '<A-j>', '<ESC><CMD>bnext<CR>')
vim.keymap.set('i', '<A-k>', '<ESC><CMD>bprevious<CR>')
vim.keymap.set('n', '<leader>Q', '<CMD>bufdo bdelete<CR>')

-- buffer resizing
vim.keymap.set("n", "<D-j>", "<CMD>resize +2<CR>")
vim.keymap.set("n", "<D-k>", "<CMD>resize -2<CR>")
vim.keymap.set("n", "<D-h>", "<CMD>vertical resize -2<CR>")
vim.keymap.set("n", "<D-l>", "<CMD>vertical resize +2<CR>")

-- terminal navigation
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-h>', '<C-\\><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-w>l')

-- terminal setup
vim.keymap.set('n', '<leader>tt', '<CMD>vsp term://' .. vim.o.shell .. '<CR>')
vim.keymap.set('n', '<leader>tA', terminal.run_target_command)
vim.keymap.set('n', '<leader>ta', terminal.run_previous_command)
vim.keymap.set('n', '<leader>tS', terminal.set_target)
vim.keymap.set('n', '<leader>ts', terminal.toggle_target)
