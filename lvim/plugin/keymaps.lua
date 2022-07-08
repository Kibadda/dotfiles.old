vim.keymap.set("n", "<A-w>", "<cmd>silent w<cr>")
vim.keymap.set("n", "<A-q>", "<cmd>BufferKill<cr>")
vim.keymap.set({ "n", "i", "t" }, "<A-l>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set({ "n", "i", "t" }, "<A-h>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<A-f>", "<cmd>LvimToggleFormatOnSave<cr>")

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
