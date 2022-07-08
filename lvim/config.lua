-- LunarVim settings
lvim.line_wrap_cursor_movement = false
-- :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.notify.active = true

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "yaml",
  "php",
  "vue",
}

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- :LvimCacheReset
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "volar" })
require("lvim.lsp.manager").setup "intelephense"

require("lvim.lsp.null-ls.formatters").setup {
  {
    name = "stylua",
    args = {
      "-f",
      "/home/michael/.dotfiles/lvim/stylua.toml",
    },
  },
}

lvim.plugins = {
  -- Startscreen
  { "mhinz/vim-startify" },
  -- essential tpope stuff
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  -- extra vim syntax
  { "fladson/vim-kitty" },
  -- other stuff
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "folke/zen-mode.nvim" },
  { "folke/twilight.nvim" },
  { "sickill/vim-pasta" },
  { "nvim-neorg/neorg-telescope" },
  { "nvim-neorg/neorg" },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      }
    end,
  },
}
