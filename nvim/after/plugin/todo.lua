if not pcall(require, "todo-comments") then
  return
end

require("todo-comments").setup {}

RegisterKeymaps("n", "<Leader>", {
  s = {
    t = { "<Cmd>TodoTelescope<CR>", "Todos" },
  },
})
