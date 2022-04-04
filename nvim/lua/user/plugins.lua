local packer = require 'lib.packer-init'

packer.startup(function (use)
  use { 'wbthomason/packer.nvim' } -- Let packer manage itself

  use { 'airblade/vim-rooter' }
  use { 'farmergreg/vim-lastplace' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-eunuch' } -- Adds :Rename, :SudoWrite
  use { 'tpope/vim-unimpaired' } -- Adds [b and other handy mappings
  use { 'tpope/vim-sleuth' } -- Indent autodetection with editorconfig support
  use { 'jessarcher/vim-heritage' } -- Automatically create parent dirs when saving
  use { 'nelstrom/vim-visual-star-search' }

  use {
    'tpope/vim-projectionist',
    config = function()
      require('user.plugins.projectionist')
    end
  }

  use {
    'navarasu/onedark.nvim',
    config = function()
      require('user.plugins.colorscheme')
    end
  }

  use {
    'tommcdo/vim-lion',
    config = function()
      require('user.plugins.lion')
    end
  }

  use {
    'sickill/vim-pasta',
    config = function()
      require('user.plugins.pasta')
    end
  }

  use {
    'jessarcher/vim-sayonara',
    config = function()
      require('user.plugins.sayonara')
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('user.plugins.indent-blankline')
    end
  }

  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('user.plugins.splitjoin')
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.bufferline')
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.lualine')
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.nvim-tree')
    end
  }

  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('user.plugins.neoscroll')
    end
  }

  -- use {
  --   'Kibadda/vim-test',
  --   config = function()
  --     require('user.plugins.vim-test')
  --   end
  -- }

  use {
    'voldikss/vim-floaterm',
    config = function()
      require('user.plugins.floaterm')
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
    },
    config = function()
      require('user.plugins.telescope')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'lewis6991/spellsitter.nvim',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('user.plugins.treesitter')
      require('spellsitter').setup()
    end
  }

  -- use {
  --   'tpope/vim-fugitive',
  --   requires = 'tpope/vim-rhubarb',
  --   cmd = 'G',
  -- }

  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup { sign_priority = 20 }
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'b0o/schemastore.nvim',
      'folke/lsp-colors.nvim',
      'weilbith/nvim-code-action-menu',
    },
    config = function ()
      require('user.plugins.lspconfig')
    end
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup{}
    end,
  }

  -- use {
  --   'L3MON4D3/LuaSnip',
  --   config = function()
  --     require('user.plugins.luasnip')
  --   end
  -- }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'jessarcher/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      require('user.plugins.cmp')
    end
  }

  -- use {
  --   'phpactor/phpactor',
  --   branch = 'master',
  --   ft = 'php',
  --   run = 'composer install --no-dev -o',
  --   config = function()
  --     require('user.plugins.phpactor')
  --   end
  -- }

  use {
    'kdheepak/lazygit.nvim',
    config = function()
      require('user.plugins.lazygit')
    end
  }

  -- use {
  --   'jwalton512/vim-blade',
  --   config = function()
  --     require('user.plugins.blade')
  --   end
  -- }

  use {
    'tpope/vim-obsession'
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'iamcco/markdown-preview.nvim',
    run = ':call mkdp#util#install()'
  }

  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('user.plugins.dashboard')
    end
  }
end)
