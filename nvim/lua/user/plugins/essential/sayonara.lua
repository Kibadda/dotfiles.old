vim.g.sayonara_filetypes = {
  NvimTree = 'NvimTreeClose',
}

vim.g.sayonara_confirm_quit = 1

vim.keymap.set('n', '<A-q>', ':Sayonara<CR>')
