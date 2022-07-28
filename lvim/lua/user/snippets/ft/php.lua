local ls = require "luasnip"

local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = require "user.snippets"
local make = shared.make

ls.add_snippets(
  "php",
  make {
    debug = fmt(
      [[
        Util::getLogger()->debug({});
      ]],
      {
        i(0),
      }
    ),

    error = fmt(
      [[
        Util::getLogger()->error({});
      ]],
      {
        i(0),
      }
    ),
  }
)
