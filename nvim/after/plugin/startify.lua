local globals = require "user.utils.globals"

if not globals.get("loaded", "startify") then
  return
end

local indices = {}
for index = 1, 99 do
  table.insert(indices, ("%d"):format(index))
end

local pad = vim.fn["startify#pad"]

globals.set("startify", {
  session_persistence = true,
  session_before_save = {
    "silent! Neotree close",
  },
  change_to_vcs_root = true,
  custom_indices = indices,
  custom_header = pad {
    "╔═══════════════════════════════════════════════════════╗",
    "║                                                       ║",
    "║  ██╗  ██╗██╗██████╗  █████╗ ██████╗ ██████╗  █████╗   ║",
    "║  ██║ ██╔╝██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗  ║",
    "║  █████╔╝ ██║██████╔╝███████║██║  ██║██║  ██║███████║  ║",
    "║  ██╔═██╗ ██║██╔══██╗██╔══██║██║  ██║██║  ██║██╔══██║  ║",
    "║  ██║  ██╗██║██████╔╝██║  ██║██████╔╝██████╔╝██║  ██║  ║",
    "║  ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝  ║",
    "║                                                       ║",
    "╚═══════════════════════════════════════════════════════╝",
  },
  lists = {
    {
      type = "sessions",
      header = pad { "Sessions" },
    },
    {
      type = "commands",
      header = pad { "Commands" },
    },
  },
  commands = {
    {
      p = "PackerSync --preview",
    },
  },
})

require("user.utils").register_keymaps {
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
