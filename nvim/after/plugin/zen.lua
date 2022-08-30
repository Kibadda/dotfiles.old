if not PluginsOk { "zen-mode", "twilight" } then
  return
end

require("zen-mode").setup {
  window = {
    backdrop = 0.999,
    height = 0.9,
    width = 140,
    options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  },
  plugins = {
    kitty = {
      enabled = true,
    },
  },
}

require("twilight").setup {
  context = 10,
  treesitter = true,
}
