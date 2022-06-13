vim.keymap.set("i", "<A-w>", "<ESC><CMD>w<CR>")
vim.keymap.set("n", "<A-w>", "<CMD>w<CR>")

vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set({ "n", "i" }, "<A-j>", "<ESC><CMD>lua NextBuffer()<CR>")
vim.keymap.set({ "n", "i" }, "<A-k>", "<ESC><CMD>lua PrevBuffer()<CR>")
vim.keymap.set("n", "<A-q>", "<CMD>lua DelBuffer()<CR>")
vim.keymap.set("n", "<Leader>Q", "<CMD>bufdo bdelete<CR>")

vim.keymap.set("n", "<Leader>K", "<CMD>nohlsearch<CR>")

vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h/')

vim.keymap.set("t", "*<ESC>", "<C-\\><C-n>")
vim.keymap.set({ "t", "n" }, "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "t", "n" }, "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "t", "n" }, "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "t", "n" }, "<C-l>", "<C-\\><C-n><C-w>l")
-- TODO: open selected file in lazygit in nvim
-- TODO: should switch to "nvim --remote" or "nvim-remote"
vim.keymap.set("t", "*o", function()
  vim.api.nvim_chan_send(vim.b.terminal_job_id, "q")
  local file = vim.fn.getreg "+"

  vim.cmd [[sleep 100m]]
  vim.cmd("e " .. file)
end)

vim.keymap.set("i", "<S-CR>", "<C-o>o")
vim.keymap.set("i", "<C-CR>", "<C-o>O")

vim.keymap.set("n", "<Leader>=", "<C-w>=")

vim.keymap.set("n", "<A-t>", "<C-w>+")
vim.keymap.set("n", "<A-s>", "<C-w>-")
vim.keymap.set("n", "<C-,>", "<C-w><")
vim.keymap.set("n", "<C-.>", "<C-w>>")
