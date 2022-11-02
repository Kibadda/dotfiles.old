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
    use "akinsho/bufferline.nvim"
    use "AndrewRadev/splitjoin.vim"
    use "dhruvasagar/vim-open-url"
    use "echasnovski/mini.nvim"
    use "ethanholz/nvim-lastplace"
    use "fladson/vim-kitty"
    use "folke/noice.nvim"
    use "folke/todo-comments.nvim"
    use "folke/which-key.nvim"
    use "itchyny/calendar.vim"
    use "justinhj/battery.nvim"
    use "karb94/neoscroll.nvim"
    use "kevinhwang91/nvim-bqf"
    use "kylechui/nvim-surround"
    use "lewis6991/gitsigns.nvim"
    use "lewis6991/impatient.nvim"
    use "mhinz/vim-startify"
    use "MrcJkb/haskell-tools.nvim"
    use "mrjones2014/smart-splits.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "numToStr/Comment.nvim"
    use "nvim-lualine/lualine.nvim"
    use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x" }
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-symbols.nvim"
    use "otavioschwanck/telescope-alternate.nvim"
    use "romainl/vim-qf"
    use "sickill/vim-pasta"
    use { "toppair/peek.nvim", run = "deno task --quiet build:fast" }
    use "tpope/vim-dotenv"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"
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
    local local_use = function(name, opts)
      opts = opts or {}

      local path = ("~/plugins/%s"):format(name)
      if vim.fn.isdirectory(vim.fn.expand(path)) == 1 then
        opts[1] = path
      else
        opts[1] = ("Kibadda/%s"):format(name)
      end

      use(opts)
    end
    local_use "laravel-docs.nvim"
    local_use "markdown-docs.nvim"
  end,
  config = {
    autoremove = true,
  },
}
