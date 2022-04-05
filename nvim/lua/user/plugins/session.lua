local keymap = require 'lib.utils'.keymap

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

require('auto-session').setup{
  auto_save_enabled = true,
}

require('session-lens').setup{
  path_display = {'shorten'},
  previewer = false,
}

keymap('n', '<leader>S', ':Telescope session-lens search_session<CR>')
