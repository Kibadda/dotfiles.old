local ls = require "luasnip"

local snippet_from_nodes = ls.sn
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = R "kibadda.snips"
local make = shared.make

local require_var = function(args, _)
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })

  local options = {}
  for len = 0, #split - 1 do
    table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end

  return snippet_from_nodes(nil, {
    c(1, options),
  })
end

ls.add_snippets(
  "lua",
  make {
    ignore = "--stylua: ignore",

    f = fmt("function({})\n  {}\nend", { i(1), i(0) }),

    lf = fmt("local function {}({})\n  {}\nend", { i(1, "name"), i(2), i(0) }),

    mf = fmt("function M.{}({})\n  {}\nend", { i(1, "name"), i(2), i(0) }),

    req = fmt([[local {} = require("{}")]], {
      d(2, require_var, { 1 }),
      i(1),
    }),

    treq = fmt([[local {} = require("telescope.{}")]], {
      d(2, require_var, { 1 }),
      i(1),
    }),
  }
)
