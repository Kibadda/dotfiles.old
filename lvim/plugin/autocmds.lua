local TerminalGroup = vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = TerminalGroup,
  pattern = "*",
  callback = function()
    vim.opt_local.filetype = "term"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
    vim.cmd [[startinsert]]
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = TerminalGroup,
  pattern = "term://*",
  command = "startinsert",
})

vim.api.nvim_create_autocmd("TermClose", {
  group = TerminalGroup,
  pattern = "*",
  command = "bdelete!",
})

local StartifyGroup = vim.api.nvim_create_augroup("Startify", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = StartifyGroup,
  pattern = "StartifyReady",
  callback = function()
    vim.cmd [[cd ~]]
  end,
})
