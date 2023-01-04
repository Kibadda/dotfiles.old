local M = {
  "folke/todo-comments.nvim",
}

function M.config()
  require("todo-comments").setup {
    keywords = {
      CRTX = { icon = "🔥", color = "warning" },
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)>\s*]],
    },
  }

  require("user.utils.register").keymaps {
    mode = "n",
    prefix = "<Leader>",
    {
      s = {
        t = { "<Cmd>TodoTelescope<CR>", "Todos" },
      },
    },
  }
end

return M
