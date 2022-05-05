require('trouble').setup{
  action_keys = {
    open_split = {},
    open_vsplit = {},
    open_tab = {},
  }
}

vim.keymap.set('n', '<leader>xc', ':TroubleClose<CR>')
vim.keymap.set('n', '<leader>xx', ':Trouble<CR>')
vim.keymap.set('n', '<leader>xw', ':Trouble workspace_diagnostics<CR>')
vim.keymap.set('n', '<leader>xd', ':Trouble document_diagnostics<CR>')
vim.keymap.set('n', '<leader>xl', ':Trouble loclist<CR>')
vim.keymap.set('n', '<leader>xq', ':Trouble quickfix<CR>')
vim.keymap.set('n', '<leader>gR', ':Trouble lsp_references<CR>')

