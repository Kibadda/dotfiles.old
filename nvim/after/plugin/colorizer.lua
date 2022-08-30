if not CheckPlugin "colorizer" then
  return
end

require("colorizer").setup {
  "*",
}
