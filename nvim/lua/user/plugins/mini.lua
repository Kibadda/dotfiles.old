local M = {
  "echasnovski/mini.starter",
  dependencies = {
    { "Kibadda/projectodo.nvim", dev = true },
    "echasnovski/mini.sessions",
  },
  enabled = false,
}

function M.config()
  require("mini.sessions").setup {
    hooks = {
      pre = {
        write = function()
          vim.cmd.Neotree { "close" }
        end,
      },
    },
  }

  local sections = require("projectodo").get_sections {
    plugin = "mini-starter",
    main_section = {
      name = "Dotfiles",
      sessions = { "dotfiles", "notes", "advent-of-code" },
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
end

return M
