if not PluginsOk "which-key" then
  return
end

require("which-key").setup {
  spelling = {
    enabled = true,
    suggestions = 20,
  },
  window = {
    border = "single",
  },
}

RegisterKeymaps {
  mode = "n",
  prefix = "",
  {
    ["<Leader>"] = {
      name = "<Leader>",
    },
  },
}
