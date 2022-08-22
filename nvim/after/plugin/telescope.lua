if not pcall(require, "telescope") then
  return
end

local actions = require "telescope.actions"
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
}

require("telescope").load_extension "ui-select"

require("which-key").register({
  f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
  s = {
    name = "Search",
    t = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
    h = { "<Cmd>Telescope help_tags<CR>", "Help" },
    b = { "<Cmd>Telescope builtin<CR>", "Builtin" },
  },
}, {
  prefix = "<Leader>",
})
