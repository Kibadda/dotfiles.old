vim.g.rnvimr_vanilla = true
vim.g.rnvimr_enable_ex = true
vim.g.rnvimr_enable_picker = true
vim.g.rnvimr_hide_gitignore = true
vim.g.rnvimr_border_attr = { fg = 14, bg = -1 }
vim.g.rnvimr_enable_bw = true
vim.g.rnvimr_ranger_cmd = { "ranger", "--cmd=set draw_borders both" }
vim.cmd [[highlight link RnvimrNormal CursorLine]]

RegisterKeymaps("n", "<Leader>", {
  e = { "<Cmd>RnvimrToggle<CR>", "Browse Files" },
})
