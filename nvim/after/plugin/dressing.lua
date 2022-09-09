if not PluginsOk "dressing" then
  return
end

require("dressing").setup {
  select = {
    telescope = require("telescope.themes").get_ivy { ... },
  },
}
