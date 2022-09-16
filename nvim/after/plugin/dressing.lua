if not PluginsOk "dressing" then
  return
end

require("dressing").setup {
  input = {
    winblend = 0,
  },
  select = {
    telescope = require("telescope.themes").get_ivy { ... },
  },
}
