local M = {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
}

function M.config()
  require("luasnip").cleanup()

  require("luasnip.loaders.from_lua").load {
    paths = vim.fn.stdpath "config" .. "/snippets",
  }
end

return M
