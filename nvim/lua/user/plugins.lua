return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"

    -- Dependencies
    use "kyazdani42/nvim-web-devicons"
    use "MunifTanjim/nui.nvim"
    use "nvim-lua/plenary.nvim"

    -- Colorscheme
    use "tjdevries/colorbuddy.nvim"
    use "tjdevries/gruvbuddy.nvim"

    -- Plugins
    use "AckslD/messages.nvim"
    use "akinsho/bufferline.nvim"
    use "alexghergh/nvim-tmux-navigation"
    use "AndrewRadev/splitjoin.vim"
    use "dhruvasagar/vim-open-url"
    use "ethanholz/nvim-lastplace"
    use "fladson/vim-kitty"
    use "folke/noice.nvim"
    use "folke/which-key.nvim"
    use "folke/todo-comments.nvim"
    use "folke/zen-mode.nvim"
    use "folke/twilight.nvim"
    use { "iamcco/markdown-preview.nvim", run = "cd app && npm install" }
    use "itchyny/calendar.vim"
    use "ja-ford/delaytrain.nvim"
    use "justinhj/battery.nvim"
    use "karb94/neoscroll.nvim"
    use "kevinhwang91/nvim-bqf"
    use "kevinhwang91/rnvimr"
    use "kylechui/nvim-surround"
    use "lewis6991/gitsigns.nvim"
    use "lewis6991/impatient.nvim"
    use "mhinz/vim-startify"
    use "norcalli/nvim-colorizer.lua"
    use "numToStr/Comment.nvim"
    use "nvim-lualine/lualine.nvim"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/playground"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-symbols.nvim"
    use "otavioschwanck/telescope-alternate.nvim"
    use "phaazon/mind.nvim"
    use "rcarriga/nvim-notify"
    use "rest-nvim/rest.nvim"
    use "romainl/vim-qf"
    use "sickill/vim-pasta"
    use "stevearc/dressing.nvim"
    use "tpope/vim-repeat"
    use "tpope/vim-dotenv"
    use "VonHeikemen/searchbox.nvim"
    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"

    -- Lsp and Cmp
    use "folke/lua-dev.nvim"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "jayp0521/mason-null-ls.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "L3MON4D3/LuaSnip"
    use "neovim/nvim-lspconfig"
    use "saadparwaiz1/cmp_luasnip"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    -- self
    use "Kibadda/laravel-docs.nvim"
  end,
  config = {
    autoremove = true,
  },
}
