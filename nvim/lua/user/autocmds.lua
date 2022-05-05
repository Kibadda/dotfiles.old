local utils = require('lib.utils')
local core = require('lib.core')

------------------------------------

vim.api.nvim_create_augroup('Misc', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Misc',
  pattern = '*',
  callback = utils.strip_trailing_whitespaces,
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'Misc',
  pattern = {
    'calendar',
  },
  command = 'setlocal nospell'
})

------------------------------------

vim.api.nvim_create_augroup('Configs', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'Configs',
  pattern = {
    core.get_homedir() .. '/.dotfiles/nvim/init.lua',
    core.get_homedir() .. '/.dotfiles/nvim/lua/*.lua',
  },
  command = 'source <afile>',
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = 'Configs',
  pattern = core.get_homedir() .. '/.dotfiles/kitty/*.conf',
  command = 'setlocal filetype=bash',
})

------------------------------------

vim.defer_fn(function ()
  if utils.get_git_root() ~= 0 then
    vim.api.nvim_create_user_command('OpenInGithub', function (_)
      local remotes = utils.get_git_remotes()

      if #remotes > 1 then
        vim.ui.select(remotes, { prompt = 'remote> ' }, function (remote)
          utils.open_repo_on_github(remote)
        end)
      else
        utils.open_repo_on_github(remotes[1])
      end
    end, {
      bang = true,
      nargs = 0,
      desc = 'Open chosen remote on Github, in the Browser'
    })
  end
end, 0)
