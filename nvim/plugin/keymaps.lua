vim.keymap.set("i", "<A-w>", "<ESC><CMD>w<CR>")
vim.keymap.set("n", "<A-w>", "<CMD>w<CR>")

vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<A-j>", "<CMD>bnext<CR>")
vim.keymap.set("n", "<A-k>", "<CMD>bprev<CR>")
vim.keymap.set("i", "<A-j>", "<ESC><CMD>bnext<CR>")
vim.keymap.set("i", "<A-k>", "<ESC><CMD>bprev<CR>")
vim.keymap.set("n", "<A-q>", "<CMD>bdelete<CR>")
vim.keymap.set("n", "<LEADER>Q", "<CMD>bufdo bdelete<CR>")

vim.keymap.set("n", "<LEADER>K", "<CMD>nohlsearch<CR>")

vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<LEFT><LEFT><LEFT>')

vim.keymap.set("t", "<LEADER><ESC>", "<C-\\><C-n>")
vim.keymap.set({ "t", "n" }, "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "t", "n" }, "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "t", "n" }, "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "t", "n" }, "<C-l>", "<C-\\><C-n><C-w>l")

vim.keymap.set("i", "<S-CR>", "<C-o>o")
vim.keymap.set("i", "<C-CR>", "<C-o>O")

vim.keymap.set("n", "<LEADER>=", "<C-w>=")

vim.keymap.set("n", "<A-t>", "<C-w>+")
vim.keymap.set("n", "<A-s>", "<C-w>-")
vim.keymap.set("n", "<C-,>", "<C-w><")
vim.keymap.set("n", "<C-.>", "<C-w>>")

vim.keymap.set("n", "<LEADER>ss", "<CMD>Startify<CR>")
