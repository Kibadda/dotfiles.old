local M = {}

M.setup = function (use)
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
      -- html tags auto
      'windwp/nvim-ts-autotag',
    },
    config = function()
      require('user.plugins.lsp.treesitter')
    end
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
      require('user.plugins.lsp.lspconfig')
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
      require('user.plugins.lsp.trouble')
    end
  }

  -- Language Server progress
  use {
    'j-hui/fidget.nvim',
    config = function()
      -- require('fidget').setup{}
    end,
  }

  -- snippet support
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('user.plugins.lsp.luasnip')
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
      require('user.plugins.lsp.cmp')
    end
  }

  -- Nvim Linter
  use {
    'mfussenegger/nvim-lint',
    config = function ()
      require('user.plugins.lsp.nvim-lint')
    end
  }
end

return M
