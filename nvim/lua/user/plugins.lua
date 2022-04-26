-- List of good plugins for which I have not found a good use for currently
-- tpope/vim-projectionist
-- tommcdo/vim-lion
-- vim-test/vim-test (Kibadda fork)
-- L3MON4D3/LuaSnip
-- phpactor/phpactor
-- jwalton512/vim-blade
-- feline-nvim/feline.nvim
-- ellisonleao/glow.nvim
-- nvim-neorg/neorg

local packer = require 'lib.packer-init'

packer.startup(function (use)
  -- Let packer manage itself
  use { 'wbthomason/packer.nvim' }

  -- essential plugins (like linter, formatter, treesitter)
  require('user.plugins.essential.essential').setup(use)

  -- visual plugins (like theme, status line, buffer line)
  require('user.plugins.visual.visual').setup(use)

  -- language server
  require('user.plugins.lsp.lsp').setup(use)

  -- other plugins
  require('user.plugins.other.other').setup(use)

  -- games
  require('user.plugins.games.games').setup(use)
end)
