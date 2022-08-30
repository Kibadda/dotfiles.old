if not PluginsOk "todo-comments" then
  return
end

require("todo-comments").setup {}

RegisterKeymaps("n", "<Leader>", {
  s = {
    t = { "<Cmd>TodoTelescope theme=ivy<CR>", "Todos" },
  },
})
