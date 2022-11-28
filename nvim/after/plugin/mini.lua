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

local sections = require("start-screen-sections").get_sections {
  plugin = "mini-starter",
  notes_project_header = "Current Projects",
  main_section = {
    name = "Dotfiles",
    sessions = { "dotfiles", "notes" },
  },
}

table.insert(sections, 1, function()
  return {
    {
      name = "Quit",
      action = "q",
      section = "",
    },
    {
      name = "Edit New Buffer",
      action = "enew",
      section = "",
    },
  }
end)

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
