local M = {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
}

M.opts = {
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

return M
