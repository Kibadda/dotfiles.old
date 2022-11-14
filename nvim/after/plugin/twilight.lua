if not plugins_ok "twilight" then
  return
end

require("twilight").setup {
  context = 10,
  treesitter = true,
}
