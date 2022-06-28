_ = vim.cmd [[packadd packer.nvim]]
_ = vim.cmd [[packadd vimball]]

vim.keymap.set("n", "<Leader>ep", "<CMD>e nvim/lua/kibadda/plugins.lua<CR>")

return require("packer").startup {
  function(use)
    local function local_use(first, second, opts)
      opts = opts or {}

      local plug_path, home
      if second == nil then
        plug_path = first
        home = "Kibadda"
      else
        plug_path = second
        home = first
      end

      if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
        opts[1] = "~/plugins/" .. plug_path
      else
        opts[1] = string.format("%s/%s", home, plug_path)
      end

      use(opts)
    end

    -- Packer
    use "wbthomason/packer.nvim"

    -- Better icons
    use "kyazdani42/nvim-web-devicons"

    -- Show key visualization
    use "folke/which-key.nvim"
    -- Pretty TODO
    use "folke/todo-comments.nvim"
    use "folke/zen-mode.nvim"
    use "folke/twilight.nvim"

    -- Basic lua stuff
    use "nvim-lua/plenary.nvim"

    -- Lua helptags
    use "milisims/nvim-luaref"

    -- TjDevries stuff
    use "tjdevries/colorbuddy.nvim"
    use "tjdevries/gruvbuddy.nvim"
    use "tjdevries/nlua.nvim"
    use "tjdevries/complextras.nvim"

    -- My own stuff
    -- tabline
    local_use "tabline.nvim"
    -- statusline
    local_use "statusline.nvim"

    -- Colorscheme
    use "Th3Whit3Wolf/onebuddy"

    -- Commenting
    use "numToStr/Comment.nvim"

    -- TPope stuff
    use "tpope/vim-surround"
    use "tpope/vim-abolish"
    use "tpope/vim-repeat"
    use "tpope/vim-sleuth"
    use "tpope/vim-scriptease"

    -- Built-in LSP
    use "neovim/nvim-lspconfig"
    use "nvim-lua/lsp-status.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"

    -- Better notifications
    use "rcarriga/nvim-notify"

    -- Telescope
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

    -- Colorizer
    use "norcalli/nvim-colorizer.lua"

    -- Completion engine
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    -- use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "tamago324/cmp-zsh"
    use "L3MON4D3/LuaSnip"
    use "onsails/lspkind-nvim"

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Linter
    use "mfussenegger/nvim-lint"

    -- FixCursorHold
    use {
      "antoinemadec/FixCursorHold.nvim",
      run = function()
        vim.g.cursorhold_updatetime = 1000
      end,
    }

    -- Startscreen and session
    use "mhinz/vim-startify"

    -- One-Liner to Multi-Liner and back
    use "AndrewRadev/splitjoin.vim"

    -- paste indentation
    use "sickill/vim-pasta"

    -- smarty
    use "blueyed/smarty.vim"

    -- intelligent brackets
    use "windwp/nvim-autopairs"

    -- Places cursor at the last place of edit
    use "farmergreg/vim-lastplace"

    -- Better scrolling
    use "karb94/neoscroll.nvim"

    -- Markdown previewer
    use { "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" }

    -- qf improvements
    use "romainl/vim-qf"

    -- latex
    use "lervag/vimtex"

    -- note taking
    use "nvim-neorg/neorg-telescope"
    use "nvim-neorg/neorg"

    -- color picker
    use "ziontee113/color-picker.nvim"

    -- kitty conf highlighting
    use "fladson/vim-kitty"

    -- use "lewis6991/gitsigns.nvim"
    -- use "folke/trouble.nvim"
    -- use "mg979/vim-visual-multi"
  end,
  config = {
    luarocks = {
      python_cmd = "python3",
    },
  },
}
