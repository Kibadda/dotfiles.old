if not PluginsOk "which-key" then
  return
end

require("which-key").setup {
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  window = {
    border = "single",
  },
}

require("user.utils").register_keymaps {
  mode = "n",
  prefix = "",
  {
    ["<Leader>"] = {
      name = "<Leader>",
    },
  },
}
