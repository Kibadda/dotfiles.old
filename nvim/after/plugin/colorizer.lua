if not plugins_ok "colorizer" then
  return
end

require("colorizer").setup {
  "*",
}
