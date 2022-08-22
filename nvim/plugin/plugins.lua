_ = vim.cmd [[packadd packer.nvim]]
_ = vim.cmd [[packadd vimball]]

return require("packer").startup {
  function(use)
    local function local_use(first, second, opts)
      opts = opts or {}

      local plug_path, home

      -- default user is Kibadda
      if second == nil then
        plug_path = first
        home = "Kibadda"
      else
        plug_path = second
        home = first
      end

      -- check if package exists locally
      if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
        opts[1] = "~/plugins/" .. plug_path
      else
        opts[1] = string.format("%s/%s", home, plug_path)
      end

      use(opts)
    end

    use "wbthomason/packer.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "nvim-lua/plenary.nvim"

    use "tjdevries/colorbuddy.nvim"
    use "tjdevries/gruvbuddy.nvim"
    use "tjdevries/nlua.nvim"
    use "tjdevries/complextras.nvim"
    use "nvim-lualine/lualine.nvim"
    use "akinsho/bufferline.nvim"
    use "rcarriga/nvim-notify"
    use "mhinz/vim-startify"
    use "alexghergh/nvim-tmux-navigation"
    use "folke/which-key.nvim"
    use "numToStr/Comment.nvim"
    use "tpope/vim-repeat"
    use "fladson/vim-kitty"
    use "kylechui/nvim-surround"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"
    use "lewis6991/gitsigns.nvim"

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"

  end,
  config = {
    luarocks = {
      python_cmd = "python3",
    },
  },
}
