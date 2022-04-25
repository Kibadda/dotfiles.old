local parser_config = require('nvim-treesitter.parsers').get_parser_configs();

require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  indent = {
    enable = { 'php', 'html', 'smarty' },
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
  autotag = {
    enable = true,
    filetypes = { 'html', 'php', 'smarty', 'tpl' },
  }
}

-- require('nvim-ts-autotag').setup{
--   filetypes = { 'html', 'php', 'smarty' },
-- }
