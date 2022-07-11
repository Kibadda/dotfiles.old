-- LunarVim settings
lvim.line_wrap_cursor_movement = false
-- :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.notify.active = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.plugins.presets.windows = true

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
  { "ethanholz/nvim-lastplace" },
  { "folke/todo-comments.nvim" },
  { "folke/zen-mode.nvim" },
  { "folke/twilight.nvim" },
  { "sickill/vim-pasta" },
  { "nvim-neorg/neorg-telescope" },
  { "nvim-neorg/neorg" },
  { "metakirby5/codi.vim" },
  { "karb94/neoscroll.nvim" },
  { "AndrewRadev/splitjoin.vim" },
}
