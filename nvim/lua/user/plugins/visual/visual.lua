local M = {}

M.setup = function (use)
  -- Bufferline
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.visual.bufferline')
    end
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.visual.lualine')
    end
  }

  -- other "lualine"
  use {
    'feline-nvim/feline.nvim',
    config = function ()
      -- require('user.plugins.visual.feline')
    end
  }

  -- File Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user.plugins.visual.fileexplorer')
    end
  }

  -- Dashboard when opening without file
  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('user.plugins.visual.dashboard')
    end
  }

  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup{}
    end
  }

  -- Smooth scrolling with <C-k> and <C-j>
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('user.plugins.visual.neoscroll')
    end
  }

  -- See list of available commands after pressing keys
  use {
    "folke/which-key.nvim",
    config = function()
      require('user.plugins.visual.which-key')
    end
  }

  -- Theme
  use {
    'rmehri01/onenord.nvim',
    -- requires = {
    --   'navarasu/onedark.nvim',
    --   'Mofiqul/vscode.nvim',
    -- },
    config = function()
      require('user.plugins.visual.colorscheme')
    end
  }

  -- Indent visualization
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('user.plugins.visual.indent-blankline')
    end
  }

  -- Floating terminal window
  use {
    'voldikss/vim-floaterm',
    config = function()
      require('user.plugins.visual.floaterm')
    end
  }

  -- Notify
  use {
    'rcarriga/nvim-notify',
    config = function ()
      require('user.plugins.visual.notify')
    end
  }
end

return M
