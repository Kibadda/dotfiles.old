if not GetGlobal("loaded", "startify") then
  return
end

local indices = {}
for index = 1, 99 do
  table.insert(indices, "" .. index)
end

local pad = vim.fn["startify#pad"]

SetGlobal("startify", {
  session_persistence = true,
  change_to_vcs_root = true,
  custom_indices = indices,
  session_savevars = {
    "g:lsp_auto_format",
  },
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
      p = "PackerSync",
    },
    {
      d = "DetachTmux",
    },
  },
})

RegisterKeymaps {
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
