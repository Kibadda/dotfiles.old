local parser_config = require('nvim-treesitter.parsers').get_parser_configs();

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  indent = {
    enable = { 'php', 'html' },
  },
  highlight = {
    enable = true,
    disable = { 'NvimTree' },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['ia'] = '@parameter.inner',
      },
    },
  },
  context_commentstring = {
    enable = true,
  },
}
