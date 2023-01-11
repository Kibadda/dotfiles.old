local M = {
  "folke/which-key.nvim",
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        name = "<Leader>",
      },
    },
  }
end

M.opts = {
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  window = {
    border = "single",
  },
}

return M
