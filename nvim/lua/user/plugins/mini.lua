local M = {
  "echasnovski/mini.starter",
  dependencies = {
    {
      "Kibadda/projectodo.nvim",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
      dev = true,
    },
  },
  lazy = false,
  priority = 999,
}

function M.config()
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
