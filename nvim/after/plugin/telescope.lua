if not pcall(require, "telescope") then
  return
end

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
    file_ignore_patterns = {
      "dotbot",
      "vendor",
    },
  },
}

require("telescope").load_extension "ui-select"
require("telescope").load_extension "fzy_native"

RegisterKeymaps("n", "<Leader>", {
  f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
  F = { "<Cmd>Telescope find_files no_ignore=true<CR>", "Find All Files" },
  s = {
    name = "Search",
    g = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
    h = { "<Cmd>Telescope help_tags<CR>", "Help" },
    b = { "<Cmd>Telescope builtin<CR>", "Builtin" },
    n = { "<Cmd>Telescope notify<CR>", "Notifications" },
    k = { "<Cmd>Telescope keymaps<CR>", "Keymaps" },
    H = { "<Cmd>Telescope highlights<CR>", "Highlights" },
    r = { "<Cmd>Telescope registers<CR>", "Registers" },
    c = { "<Cmd>Telescope commands<CR>", "Commands" },
    R = { "<Cmd>Telescope resume<CR>", "Resume" },
  },
})
