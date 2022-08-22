vim.g.mapleader = " "

local wk = require("which-key")

wk.register({
  g = {
    name = "Git",
    g = { "<Cmd>OpenTerminal lazygit<CR>", "Lazygit" },
  },
  P = {
    name = "Packer",
    s = { "<Cmd>PackerSync<CR>", "Sync" },
    i = { "<Cmd>PackerInstall<CR>", "Install" },
    c = { "<Cmd>PackerCompile<CR>", "Compile" },
  },
}, {
  prefix = "<Leader>",
})

wk.register({
  Y = { "y$", "Yank till EOF" }
}, {
  prefix = "",
})
