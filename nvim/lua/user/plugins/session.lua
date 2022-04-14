local keymap = require 'lib.utils'.keymap

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

local function restore_nvim_tree()
  require('nvim-tree').change_dir(vim.fn.getcwd())
end

require('auto-session').setup{
  auto_save_enabled = true,
  auto_session_suppress_dirs = {'~/'},
  post_restore_cmds = {restore_nvim_tree},
}

require('session-lens').setup{
  path_display = {'shorten'},
  previewer = false,
}

keymap('n', '<leader>S', ':Telescope session-lens search_session<CR>')
