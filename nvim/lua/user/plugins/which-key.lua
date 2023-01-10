local M = {
  "folke/which-key.nvim",
}

function M.config()
  require("which-key").setup {
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

  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        name = "<Leader>",
      },
    },
  }
end

return M
