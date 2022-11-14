if not plugins_ok "luasnip" then
  return
end

require("luasnip").cleanup()

require("luasnip.loaders.from_lua").load {
  paths = "~/.config/nvim/snippets",
}
