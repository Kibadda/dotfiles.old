if not pcall(require, "todo-comments") then
  return
end

require("todo-comments").setup {}

RegisterKeymaps("<Leader>", {
  s = {
    t = { "<Cmd>TodoTelescope<CR>", "Todos" },
  },
})
