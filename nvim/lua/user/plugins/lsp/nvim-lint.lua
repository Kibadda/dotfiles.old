require('lint').linters_by_ft = {
  php = {'phpcs'}
}

local phpcs = require('lint.linters.phpcs')
phpcs.args = {
  '-q',
  '--standard=~/.config/nvim/lua/user/external/ruleset.xml',
  '--report=json',
  '-',
}

vim.api.nvim_create_augroup('NvimLint', { clear = true })

vim.api.nvim_create_autocmd('BufRead', {
  group = 'NvimLint',
  pattern = '*',
  callback = function ()
    require('lint').try_lint()
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'NvimLint',
  pattern = '*',
  callback = function ()
    require('lint').try_lint()
  end,
})
