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
  custom_header = pad {
    "╔═══════════════════════════════════════════════════════╗",
    "║                                                       ║",
    "║  ██╗  ██╗██╗██████╗  █████╗ ██████╗ ██████╗  █████╗   ║",
    "║  ██║ ██╔╝██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗  ║",
    "║  █████╔╝ ██║██████╔╝███████║██║  ██║██║  ██║███████║  ║",
    "║  ██╔═██╗ ██║██╔══██╗██╔══██║██║  ██║██║  ██║██╔══██║  ║",
    "║  ██║ ╚██╗██║██████╔╝██║  ██║██████╔╝██████╔╝██║  ██║  ║",
    "║  ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝  ║",
    "║                                                       ║",
    "╚═══════════════════════════════════════════════════════╝",
  },
  lists = {
    {
      type = "sessions",
      header = pad { "Sessions" },
      indices = indices,
    },
    {
      type = function()
        local query_string = [[
          (todo_item1
            state: (todo_item_undone)
            content: (paragraph (paragraph_segment) @todo)
          )
        ]]

        local directory = vim.fn.expand "$HOME/notes"
        local file = string.format("%s/index.norg", directory)
        local file_string = table.concat(vim.fn.readfile(file), "\n")

        local captures = {}

        local parser = vim.treesitter.get_string_parser(file_string, "norg", {})
        local root = parser:parse()[1]:root()
        local query = vim.treesitter.parse_query("norg", query_string)

        for _, node in query:iter_captures(root) do
          table.insert(captures, {
            line = vim.treesitter.get_node_text(node, file_string),
            cmd = "",
          })
        end

        return vim.list_slice(captures, 1, 10)
      end,
      header = pad { "Todos" },
      indices = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " },
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
