if not PluginsOk "todo-comments" then
  return
end

require("todo-comments").setup {}

require("user.utils").register_keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    s = {
      t = { "<Cmd>TodoTelescope<CR>", "Todos" },
    },
  },
}
