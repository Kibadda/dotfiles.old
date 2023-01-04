return {
  -- Dependencies
  "kyazdani42/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",

  -- Plugins
  "fladson/vim-kitty",
  "tpope/vim-dotenv",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "sickill/vim-pasta",
  "dhruvasagar/vim-open-url",
  "romainl/vim-qf",
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup { "*" }
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup {}
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  { "Kibadda/advent-of-code", dev = true },
  { "Kibadda/laravel-docs.nvim", dev = true },
  { "Kibadda/markdown-docs.nvim", dev = true },
}
