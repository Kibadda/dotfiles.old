vim.keymap.set("i", "<A-w>", "<ESC><CMD>w<CR>")
vim.keymap.set("n", "<A-w>", "<CMD>w<CR>")

vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set({ "n", "i", "t" }, "<A-j>", "<CMD>bnext<CR>")
vim.keymap.set({ "n", "i", "t" }, "<A-k>", "<CMD>bprevious<CR>")
vim.keymap.set("n", "<A-q>", "<CMD>bdelete()<CR>")
vim.keymap.set("n", "<Leader>Q", "<CMD>bufdo bdelete<CR>")

vim.keymap.set("n", "<Leader>K", "<CMD>nohlsearch<CR>")

vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h/')

vim.keymap.set("i", "<S-CR>", "<C-o>o")
vim.keymap.set("i", "<C-CR>", "<C-o>O")

vim.keymap.set("n", "<Leader>=", "<C-w>=")

vim.keymap.set({ "t", "n" }, "<S-Left>", "<CMD>vertical resize +5<CR>")
vim.keymap.set({ "t", "n" }, "<S-Right>", "<CMD>vertical resize -5<CR>")
vim.keymap.set({ "t", "n" }, "<S-Up>", "<CMD>resize +5<CR>")
vim.keymap.set({ "t", "n" }, "<S-Down>", "<CMD>resize -5<CR>")

vim.keymap.set("t", "*<ESC>", "<C-\\><C-n>")
vim.keymap.set({ "t", "n" }, "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "t", "n" }, "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "t", "n" }, "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "t", "n" }, "<C-l>", "<C-\\><C-n><C-w>l")
