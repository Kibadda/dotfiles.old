if not PluginsOk "neo-tree" then
  return
end

require("neo-tree").setup {
  close_if_last_window = true,
  popup_border_style = "single",
  window = {
    position = "right",
    width = 50,
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
  },
}

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    e = { "<Cmd>Neotree reveal<CR>", "Open/Focus Neotree" },
    E = { "<Cmd>Neotree close<CR>", "Close Neotree" },
  },
}
