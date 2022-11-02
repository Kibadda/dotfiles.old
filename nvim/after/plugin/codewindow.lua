if not PluginsOk "codewindow" then
  return
end

require("codewindow").setup {}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    c = {
      name = "Codewindow",
      o = { require("codewindow").open_minimap, "Open" },
      c = { require("codewindow").close_minimap, "Close" },
      t = { require("codewindow").toggle_minimap, "Toggle" },
      f = { require("codewindow").toggle_focus, "Focus" },
    },
  },
}
