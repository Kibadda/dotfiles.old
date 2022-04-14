local packer = require 'lib.packer-init'

packer.startup(function (use)
  -- Let packer manage itself
  use { 'wbthomason/packer.nvim' }

  -- Sets root of directory
  use { 'airblade/vim-rooter' }
  -- Places cursor at the last place of edit
  use { 'farmergreg/vim-lastplace' }
  -- gcc
  use { 'tpope/vim-commentary' }
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
  -- better start and hashtag search
  use { 'nelstrom/vim-visual-star-search' }

  -- Markdown Preview
  use {
    'iamcco/markdown-preview.nvim',
    run = ':call mkdp#util#install()'
  }

  -- See list of available commands after pressing keys
  use {
    "folke/which-key.nvim",
    config = function()
      require('user.plugins.which-key')
    end
  }

  -- Theme
  use {
    'navarasu/onedark.nvim',
    config = function()
      require('user.plugins.colorscheme')
    end
  }

  -- p and P respect indentation
  use { 'sickill/vim-pasta' }

  -- Better closing of buffers
  use {
    'jessarcher/vim-sayonara',
    config = function()
      require('user.plugins.sayonara')
    end
  }

  -- Indent visualization
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('user.plugins.indent-blankline')
    end
  }

  -- One-Liner to Multi-Liner and back
  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('user.plugins.splitjoin')
    end
  }

  -- intelligent brackets
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('user.plugins.autopairs')
    end
  }

  -- Bufferline
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.bufferline')
    end
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.lualine')
    end
  }

  -- File Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.nvim-tree')
    end
  }

  -- Smooth scrolling with <C-k> and <C-j>
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('user.plugins.neoscroll')
    end
  }

  -- Floating terminal window
  use {
    'voldikss/vim-floaterm',
    config = function()
      require('user.plugins.floaterm')
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
    },
    config = function()
      require('user.plugins.telescope')
    end
  }

  -- A lot
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/playground',
      -- Adding custom textobjects
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- Intelligent spell check
      'lewis6991/spellsitter.nvim',
      -- intelligent comment string based on context
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('user.plugins.treesitter')
      require('spellsitter').setup()
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

  -- Language Server
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

  -- auto format
  use {
    'lukas-reineke/lsp-format.nvim',
    config = function()
      require('lsp-format').setup{}
    end
  }

  -- Diagnostics
  use {
    'folke/trouble.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require('user.plugins.trouble')
    end
  }

  -- Language Server progress
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup{}
    end,
  }

  -- Dashboard when opening without file
  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('user.plugins.dashboard')
    end
  }

  use {
    'rmagatti/session-lens',
    requires = {
      'rmagatti/auto-session',
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      require('user.plugins.session')
    end
  }

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('user.plugins.luasnip')
    end
  }

  -- Completion engine
  -- TODO: look more into this plugin
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

  -- Smarty syntax
  use {
    'blueyed/smarty.vim'
  }

  -- Nvim Linter
  use {
    'mfussenegger/nvim-lint',
    config = function ()
      require('user.plugins.nvim-lint')
    end
  }

  use {
    'KadoBOT/nvim-spotify', 
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
        local spotify = require'nvim-spotify'

        spotify.setup {
            -- default opts
            status = {
                update_interval = 10000, -- the interval (ms) to check for what's currently playing
                format = '%s %t by %a' -- spotify-tui --format argument
            }
        }
    end,
    run = 'make'
  }

  -- List of good plugins for which I have not found a good use for currently
  -- tpope/vim-projectionist
  -- tommcdo/vim-lion
  -- vim-test/vim-test (Kibadda fork)
  -- L3MON4D3/LuaSnip
  -- phpactor/phpactor
  -- jwalton512/vim-blade
end)
