if not plugins_ok { "mini.sessions", "mini.starter" } then
  return
end

require("mini.sessions").setup {
  hooks = {
    pre = {
      write = function()
        vim.cmd.Neotree { "close" }
      end,
    },
  },
}

local builtin = require("mini.starter").sections.builtin_actions()
local sections = require("start-screen-sections").get_sections {
  plugin = "mini",
  main_section = {
    name = "Dotfiles",
    sessions = { "dotfiles", "notes" },
  },
}

table.insert(sections, 1, builtin)

require("mini.starter").setup {
  header = table.concat({
    "┌───────────────────────────────────────────────────────┐",
    "│                                                       │",
    "│  ██┐  ██┐██┐██████┐  █████┐ ██████┐ ██████┐  █████┐   │",
    "│  ██│ ██┌┘██│██┌──██┐██┌──██┐██┌──██┐██┌──██┐██┌──██┐  │",
    "│  █████┌┘ ██│██████┌┘███████│██│  ██│██│  ██│███████│  │",
    "│  ██┌─██┐ ██│██┌──██┐██┌──██│██│  ██│██│  ██│██┌──██│  │",
    "│  ██│ └██┐██│██████┌┘██│  ██│██████┌┘██████┌┘██│  ██│  │",
    "│  └─┘  └─┘└─┘└─────┘ └─┘  └─┘└─────┘ └─────┘ └─┘  └─┘  │",
    "│                                                       │",
    "└───────────────────────────────────────────────────────┘",
  }, "\n"),
  items = sections,
  footer = "",
}
