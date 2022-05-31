local ls = require "luasnip"

local snippet_from_nodes = ls.sn
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = R "kibadda.snips"
local make = shared.make

local function foreach_var(args)
  local text = args[1][1] or ""
  local placeholder = string.sub(text, 1, -2)

  return snippet_from_nodes(nil, {
    i(1, placeholder),
  })
end

ls.add_snippets(
  "smarty",
  make {
    ["for"] = fmt(
      [[
        {{foreach ${} as ${}}}
            {}
        {{/foreach}}
      ]],
      {
        i(1),
        d(2, foreach_var, { 1 }),
        i(0),
      }
    ),

    ["if"] = fmt(
      [[
        {{if {}}}
        {}
        {{/if}}
      ]],
      {
        i(1),
        c(2, {
          snippet_from_nodes(nil, { t "    ", i(1) }),
          fmt(
            [[
                  {}
              {{else}}
                  {}
            ]],
            {
              i(1),
              i(2),
            }
          ),
        }),
      }
    ),
  }
)
