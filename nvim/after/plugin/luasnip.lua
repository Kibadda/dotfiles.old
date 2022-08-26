if not pcall(require, "luasnip") then
  return
end

local luasnip = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = luasnip.snippet
local i = luasnip.insert_node

luasnip.add_snippets("php", {
  s("debug", fmt("Util::getLogger()->debug({});", { i(0) })),
  s("info", fmt("Util::getLogger()->info({});", { i(0) })),
  s("error", fmt("Util::getLogger()->error({});", { i(0) })),
})
