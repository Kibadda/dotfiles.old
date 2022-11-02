if not PluginsOk "silicon" then
  return
end

require("silicon").setup {
  output = ("/home/michael/Pictures/SILICON_%s_%s.png"):format(os.date "%Y-%m-%d", os.date "%H-%M"),
}
