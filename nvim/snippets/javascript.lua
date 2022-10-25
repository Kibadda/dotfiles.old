local luasnip = require "luasnip"
local s = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("log", fmt("console.log({});", { i(0) })),
}, {}
