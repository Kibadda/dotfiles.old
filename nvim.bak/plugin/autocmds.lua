------------------------------------
-- Misc
------------------------------------

local MiscGroup = vim.api.nvim_create_augroup("Misc", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = MiscGroup,
  pattern = "*",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_command "%s/\\s\\+$//e"
    vim.api.nvim_win_set_cursor(0, cursor)
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = MiscGroup,
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

------------------------------------
-- Terminal
------------------------------------

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
