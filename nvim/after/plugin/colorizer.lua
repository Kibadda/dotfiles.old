if not PluginsOk "colorizer" then
  return
end

require("colorizer").setup {
  "*",
}
