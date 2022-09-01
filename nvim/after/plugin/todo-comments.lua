if not PluginsOk "todo-comments" then
  return
end

require("todo-comments").setup {}

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    s = {
      t = { "<Cmd>TodoTelescope theme=ivy<CR>", "Todos" },
    },
  },
}
