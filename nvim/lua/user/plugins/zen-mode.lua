local M = {
  "folke/zen-mode.nvim",
}

function M.config()
  require("zen-mode").setup {
    window = {
      backdrop = 0.999,
      height = 0.9,
      width = 140,
      options = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
      },
    },
    plugins = {
      kitty = {
        enabled = true,
      },
    },
  }
end

return M
