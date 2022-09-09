if not PluginsOk "emoji_picker" then
  return
end

require("emoji_picker").setup {}

RegisterKeymaps {
  mode = "i",
  prefix = "",
  {
    ["<M-e>"] = { "<Cmd>EmojiPicker<CR>", "Pick emoji" },
  },
}
RegisterKeymaps {
  mode = "t",
  prefix = "",
  {
    ["<M-e>"] = { "<Cmd>EmojiPicker<CR>", "Pick emoji" },
  },
}
