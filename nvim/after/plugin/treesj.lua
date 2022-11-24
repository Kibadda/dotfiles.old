if not plugins_ok "treesj" then
  return
end

require("treesj").setup {
  use_default_keymaps = false,
}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "",
  {
    gJ = { "<Cmd>TSJJoin<CR>", "Join Lines" },
    gS = { "<Cmd>TSJSplit<CR>", "Split Lines" },
  },
}
