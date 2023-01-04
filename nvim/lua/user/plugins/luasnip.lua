local M = {
  "L3MON4D3/LuaSnip",
}

function M.config()
  require("luasnip").cleanup()

  require("luasnip.loaders.from_lua").load {
    paths = "~/.config/nvim/snippets",
  }
end

return M
