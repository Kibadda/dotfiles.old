local M = {
  "mhinz/vim-startify",
  dependencies = {
    { "Kibadda/projectodo.nvim", dev = true },
  },
}

function M.config()
  local globals = require "user.utils.globals"

  globals.set("startify", {
    session_persistence = true,
    session_before_save = {
      "silent! Neotree close",
    },
    change_to_vcs_root = true,
    custom_header = vim.fn["startify#pad"] {
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
    },
    lists = require("projectodo").get_sections {
      plugin = "vim-startify",
      notes_project_header = "Current Projects",
      main_section = {
        name = "Dotfiles",
        sessions = { "dotfiles", "notes", "advent-of-code" },
      },
    },
  })

  require("user.utils.register").keymaps {
    mode = "n",
    prefix = "<Leader>",
    {
      S = {
        name = "Startify",
        c = { "<Cmd>SClose<CR>", "Close" },
        l = { "<Cmd>SLoad<CR>", "Load" },
        d = { "<Cmd>SDelete<CR>", "Delete" },
        s = { "<Cmd>SSave<CR>", "Save" },
      },
    },
  }
end

return M
