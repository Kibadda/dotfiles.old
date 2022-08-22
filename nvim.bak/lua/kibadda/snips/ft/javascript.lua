local ls = require "luasnip"

local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = R "kibadda.snips"
local make = shared.make

ls.add_snippets(
  "javascript",
  make {
    ef = fmt(
      [[
        exports.{} = function ({}) {{
            {}
        }};
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    ),

    f = fmt(
      [[
        function {}({}) {{
            {}
        }}
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    ),
  }
)
