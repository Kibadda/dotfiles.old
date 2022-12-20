if not plugins_ok "todo-comments" then
  return
end

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
