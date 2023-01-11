local M = {
  "folke/todo-comments.nvim",
  event = "BufEnter",
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        s = {
          t = { "<Cmd>TodoTelescope<CR>", "Todos" },
        },
      },
    },
  }
end

M.opts = {
  keywords = {
    CRTX = { icon = "🔥", color = "warning" },
  },
  highlight = {
    pattern = [[.*<(KEYWORDS)>\s*]],
  },
}

return M
