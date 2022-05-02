vim.o.sessionoptions = 'curdir'

local function restore_nvim_tree()
  require('nvim-tree').change_dir(vim.fn.getcwd())
end

require('auto-session').setup {
  auto_save_enabled = true,
  auto_session_suppress_dirs = { '~/' },
  post_restore_cmds = { restore_nvim_tree },
  log_level = 'error',
}

require('session-lens').setup {
  path_display = { 'shorten' },
  previewer = false,
}

vim.keymap.set('n', '<leader>S', ':Telescope session-lens search_session<CR>')
