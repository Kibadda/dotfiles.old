vim.g.floaterm_gitcommit = "floaterm"
vim.g.floaterm_opener = "drop"
vim.g.floaterm_keymap_toggle = "<F1>"
vim.g.floaterm_keymap_next = "<F2>"
vim.g.floaterm_keymap_prev = "<F3>"
vim.g.floaterm_keymap_new = "<F4>"
vim.g.floaterm_keymap_kill = "<F5>"
vim.g.floaterm_autoinsert = 1
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_wintitle = 0

vim.keymap.set("n", "<leader>gg", ":FloatermNew lazygit<CR>")
vim.keymap.set("n", "<leader>rr", ":FloatermNew ranger<CR>")
