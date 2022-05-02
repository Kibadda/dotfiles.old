local M = {}

M.setup = function (use)
  -- Sets root of directory
  use { 'airblade/vim-rooter' }

  -- Places cursor at the last place of edit
  use { 'farmergreg/vim-lastplace' }

  -- makes plugin commands repeatable with .
  use { 'tpope/vim-repeat' }

  -- Surround
  use { 'tpope/vim-surround' }

  -- Adds :Rename, :SudoWrite
  use { 'tpope/vim-eunuch' }

  -- Adds [b and other handy mappings
  use { 'tpope/vim-unimpaired' }

  -- Indent autodetection with editorconfig support
  use { 'tpope/vim-sleuth' }

  -- Automatically create parent dirs when saving
  use { 'jessarcher/vim-heritage' }

  -- Markdown Preview
  use {
    'iamcco/markdown-preview.nvim',
    run = ':call mkdp#util#install()'
  }

  -- p and P respect indentation
  use { 'sickill/vim-pasta' }

  -- Smarty syntax
  use { 'blueyed/smarty.vim' }

  -- gcc
  use {
    'tpope/vim-commentary',
    config = function ()
      require('user.plugins.essential.commentary')
    end
  }

  -- Better closing of buffers
  use {
    'jessarcher/vim-sayonara',
    config = function()
      require('user.plugins.essential.sayonara')
    end
  }

  -- One-Liner to Multi-Liner and back
  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('user.plugins.essential.splitjoin')
    end
  }

  -- intelligent brackets
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('user.plugins.essential.autopairs')
    end
  }

  -- Telescope: Find, History, Buffers, Live Grep
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
    },
    config = function()
      require('user.plugins.essential.telescope')
    end
  }

  -- Git visualization
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup { sign_priority = 20 }
    end,
  }

  -- Session management
  use {
    'rmagatti/session-lens',
    requires = {
      'rmagatti/auto-session',
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      require('user.plugins.essential.session')
    end
  }
end

return M
