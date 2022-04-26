local keymap = require 'lib.utils'.keymap

require('trouble').setup{
  action_keys = {
    open_split = {},
    open_vsplit = {},
    open_tab = {},
  }
}

keymap('n', '<leader>xc', ':TroubleClose<CR>')
keymap('n', '<leader>xx', ':Trouble<CR>')
keymap('n', '<leader>xw', ':Trouble workspace_diagnostics<CR>')
keymap('n', '<leader>xd', ':Trouble document_diagnostics<CR>')
keymap('n', '<leader>xl', ':Trouble loclist<CR>')
keymap('n', '<leader>xq', ':Trouble quickfix<CR>')
keymap('n', '<leader>gR', ':Trouble lsp_references<CR>')

