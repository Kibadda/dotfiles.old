local luasnip = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = luasnip.snippet
local i = luasnip.insert_node

return {
  s(
    "laf",
    fmt(
      [[
        function({})
          {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
  s(
    "lof",
    fmt(
      [[
        local function {}({})
          {}
        end
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),
}, {}
