local luasnip = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = luasnip.snippet
local i = luasnip.insert_node
local n = luasnip.snippet_node
local d = luasnip.dynamic_node
local f = luasnip.function_node

return {
  s(
    "pok",
    fmt(
      [[
        if not plugins_ok "[]" then
          return
        end

        require("[]").setup {[]}
      ]],
      {
        d(1, function()
          local current_file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")
          return n(nil, {
            i(1, current_file_name),
          })
        end),
        f(function(args)
          return args[1]
        end, { 1 }),
        i(0),
      },
      {
        delimiters = "[]",
      }
    )
  ),
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
