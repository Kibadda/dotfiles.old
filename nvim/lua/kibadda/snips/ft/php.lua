local ls = require "luasnip"

local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = R "kibadda.snips"
local same = shared.same
local make = shared.make
local sameFirstUpper = shared.sameFirstUpper

ls.add_snippets(
  "php",
  make {
    get = fmt(
      [[
        /**
         * @return {}|null
         */
        public function get{}(): ?{} {{
            return $this->{};
        }}
      ]],
      {
        same(2),
        sameFirstUpper(1),
        i(2),
        i(1),
      }
    ),

    set = fmt(
      [[
        /**
         * @param mixed ${}
         */
        public function set{}(${}): void {{
            $this->{} = ${};
        }}
      ]],
      {
        same(1),
        sameFirstUpper(1),
        same(1),
        same(1),
        i(1),
      }
    ),

    pubf = fmt(
      [[
        public function {}({}) {{
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
