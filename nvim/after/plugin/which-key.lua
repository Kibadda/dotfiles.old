if not plugins_ok "which-key" then
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

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "",
  {
    ["<Leader>"] = {
      name = "<Leader>",
    },
  },
}
