vim.api.nvim_create_autocmd('FileType', {
  pattern = 'smarty',
  command = 'setlocal commentstring={* %s *}',
})
