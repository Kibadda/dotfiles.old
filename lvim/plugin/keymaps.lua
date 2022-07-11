vim.keymap.set("n", "<A-w>", "<cmd>silent w<cr>")
vim.keymap.set("n", "<A-q>", "<cmd>BufferKill<cr>")
vim.keymap.set({ "n", "i", "t" }, "<A-l>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set({ "n", "i", "t" }, "<A-h>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<A-f>", "<cmd>ToggleFormatOnSave<cr>")

lvim.builtin.which_key.mappings["S"] = {
  name = "Startify",
  c = { "<cmd>SClose<cr>", "Close Session" },
  s = { "<cmd>SSave<cr>", "Save Session" },
  l = { "<cmd>SLoad<cr>", "Load Session" },
  d = { "<cmd>SDelete<cr>", "Delete Session" },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Terminal",
  t = { "<cmd>OpenTerminal<cr>", "Open Terminal" },
  g = { "<cmd>OpenTerminal lazygit<cr>", "Open Lazygit" },
  r = { "<cmd>OpenTerminal ranger<cr>", "Open Ranger" },
}
lvim.builtin.which_key.mappings["C"] = {
  name = "Codi",
  n = { "<cmd>CodiNew<cr>", "Open new scratch" },
  c = { "<cmd>Codi!!<cr>", "Toggle" },
  s = { "<cmd>CodiSelect<cr>", "Select filetype" },
  e = { "<cmd>CodiExpand<cr>", "Expand output" },
}
lvim.builtin.which_key.mappings["E"] = { "<cmd>BetterExplore<cr>", "Explorer" }

lvim.builtin.which_key.mappings["w"] = nil
lvim.builtin.which_key.mappings["q"] = nil
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["/"] = nil
lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["e"] = nil

require("which-key").register({
  g = {
    J = { "<cmd>SplitjoinJoin<cr>", "Join" },
    S = { "<cmd>SplitjoinSplit<cr>", "Split" },
    b = { "<Plug>(comment_toggle_blockwise)", "Toggle Comment blockwise" },
    c = { "<Plug>(comment_toggle_linewise)", "Toggle Comment linewise" },
  },
  d = {
    s = { "<Plug>Dsurround", "Delete surrounding" },
  },
  c = {
    s = { "<Plug>Csurround", "Change surrounding" },
    S = { "<Plug>CSurround", "Change surrounding (multiline)" },
  },
}, { prefix = "" })
