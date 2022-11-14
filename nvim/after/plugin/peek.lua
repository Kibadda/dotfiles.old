if not plugins_ok "peek" then
  return
end

require("peek").setup {
  update_on_change = false,
}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    m = {
      name = "Markdown",
      p = { require("peek").open, "Start" },
      s = { require("peek").close, "Stop" },
    },
  },
}
