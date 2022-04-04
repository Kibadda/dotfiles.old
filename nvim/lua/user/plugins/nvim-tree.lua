local keymap = require 'lib.utils'.keymap

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_group_empty = 1

require('nvim-tree').setup {
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}

keymap('n', '<leader>n', ':NvimTreeFindFileToggle<Cr>')
