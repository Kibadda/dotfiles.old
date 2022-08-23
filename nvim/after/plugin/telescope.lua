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
  },
}

require("telescope").load_extension "ui-select"
require("telescope").load_extension "fzy_native"
require("telescope").load_extension "file_browser"

RegisterKeymaps("<Leader>", {
  f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
  e = { "<Cmd>Telescope file_browser<CR>", "Browse Files" },
  s = {
    name = "Search",
    g = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
    h = { "<Cmd>Telescope help_tags<CR>", "Help" },
    b = { "<Cmd>Telescope builtin<CR>", "Builtin" },
  },
})
