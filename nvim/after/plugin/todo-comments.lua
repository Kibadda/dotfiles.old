if not plugins_ok "todo-comments" then
  return
end

require("todo-comments").setup {}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    s = {
      t = { "<Cmd>TodoTelescope<CR>", "Todos" },
    },
  },
}
