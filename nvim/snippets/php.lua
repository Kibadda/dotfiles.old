local luasnip = require "luasnip"
local s = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("debug", fmt("Util::getLogger()->debug({});", { i(0) })),
  s("info", fmt("Util::getLogger()->info({});", { i(0) })),
  s("error", fmt("Util::getLogger()->error({});", { i(0) })),
}, {}
