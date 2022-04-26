require('neoscroll').setup()

require('neoscroll.config').set_mappings {
  ['<C-k>'] = { 'scroll', { '-vim.wo.scroll', 'true', '50' } },
  ['<C-j>'] = { 'scroll', { 'vim.wo.scroll', 'true', '50' } },
}
