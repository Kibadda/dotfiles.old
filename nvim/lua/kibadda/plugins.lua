_ = vim.cmd [[packadd packer.nvim]]
_ = vim.cmd [[packadd vimball]]

-- local has = function (x)
--   return vim.fn.has(x) == 1
-- end

-- local executable = function (x)
--   return vim.fn.executable(x) == 1
-- end

return require("packer").startup {
  function (use)
    use "wbthomason/packer.nvim"

    use "nvim-lua/plenary.nvim"

    use "numToStr/Comment.nvim"

    use "tpope/vim-surround"
    use "tpope/vim-abolish"
    use "tpope/vim-repeat"

    use "tjdevries/colorbuddy.nvim"
    use "tjdevries/express_line.nvim"

    use "neovim/nvim-lspconfig"

    use "rcarriga/nvim-notify"

    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-rs.nvim"
    use "nvim-telescope/telescope-fzf-writer.nvim"
    use "nvim-telescope/telescope-packer.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-telescope/telescope-github.nvim"
    use "nvim-telescope/telescope-symbols.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "nvim-telescope/telescope-hop.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"

    use "norcalli/nvim-colorizer.lua"

    use "romainl/vim-qf"

    use "kyazdani42/nvim-web-devicons"
    use "yamatsum/nvim-web-nonicons"

    -- use "folke/zen-mode.nvim"
    -- use "folke/twilight.nvim"
    -- use "folke/trouble.nvim"

    use { "imacco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" }

    use "hrsh7th/nvim-cmp"
    -- use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "saadparwaiz1/cmp_luasnip"
    use "tamago324/cmp-zsh"
    use "L3MON4D3/LuaSnip"
    use "tjdevries/complextras.nvim"

    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    use "lewis6991/gitsigns.nvim"
  end,
  config = {
    luarocks = {
      python_cmd = "python3",
    },
  },
}
