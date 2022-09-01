if not PluginsOk "telescope" then
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

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    f = { "<Cmd>Telescope find_files theme=ivy<CR>", "Find Files" },
    F = { "<Cmd>Telescope find_files no_ignore=true theme=ivy<CR>", "Find All Files" },
    s = {
      name = "Search",
      g = { "<Cmd>Telescope live_grep theme=ivy<CR>", "Live Grep" },
      h = { "<Cmd>Telescope help_tags theme=ivy<CR>", "Help" },
      b = { "<Cmd>Telescope builtin theme=ivy<CR>", "Builtin" },
      n = { "<Cmd>Telescope notify theme=ivy<CR>", "Notifications" },
      k = { "<Cmd>Telescope keymaps theme=ivy<CR>", "Keymaps" },
      H = { "<Cmd>Telescope highlights theme=ivy<CR>", "Highlights" },
      r = { "<Cmd>Telescope registers theme=ivy<CR>", "Registers" },
      c = { "<Cmd>Telescope commands theme=ivy<CR>", "Commands" },
      R = { "<Cmd>Telescope resume<CR>", "Resume" },
    },
  },
}
