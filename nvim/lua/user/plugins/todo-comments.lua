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

function M.config()
  require("todo-comments").setup {
    keywords = {
      CRTX = { icon = "🔥", color = "warning" },
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)>\s*]],
    },
  }
end

return M
