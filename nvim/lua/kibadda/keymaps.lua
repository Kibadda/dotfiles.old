vim.keymap.set('i', '<A-w>', '<ESC><CMD>w<CR>')
vim.keymap.set('n', '<A-w>', '<CMD>w<CR>')

vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<A-j>', '<CMD>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<A-k>', '<CMD>BufferLineCyclePrev<CR>')
vim.keymap.set('i', '<A-j>', '<ESC><CMD>BufferLineCycleNext<CR>')
vim.keymap.set('i', '<A-k>', '<ESC><CMD>BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>Q', '<CMD>bufdo bdelete<CR>')

vim.keymap.set('n', '<leader>K', '<CMD>nohlsearch<CR>')

vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//gc<LEFT><LEFT><LEFT>')
