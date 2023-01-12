return {
  -- Dependencies
  "kyazdani42/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",

  -- Plugins
  "fladson/vim-kitty",
  {
    "tpope/vim-dotenv",
    config = function()
      local envfile = "~/.dotfiles/.env"
      if vim.fn.filereadable(vim.fn.expand(envfile)) == 0 then
        return
      end

      vim.cmd.Dotenv(envfile)
    end,
  },
  { "tpope/vim-fugitive", cmd = "G" },
  "tpope/vim-repeat",
  "sickill/vim-pasta",
  {
    "romainl/vim-qf",
    init = function()
      require("user.utils.register").keymaps {
        n = {
          ["<C-q>"] = { "<Plug>(qf_qf_toggle_stay)", "QF: toggle" },
          ["<C-Up>"] = { "<Plug>(qf_qf_previous)", "QF: prev" },
          ["<C-Down>"] = { "<Plug>(qf_qf_next)", "QF: next" },
        }
      }
    end,
  },
  { "norcalli/nvim-colorizer.lua", opts = { "*" } },
  { "nvim-zh/colorful-winsep.nvim", config = true },
  { "kylechui/nvim-surround", config = true },

  { "Kibadda/advent-of-code", dev = true },
  { "Kibadda/laravel-docs.nvim", dev = true },
}
