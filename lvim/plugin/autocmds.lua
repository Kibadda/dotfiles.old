local TerminalGroup = vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = TerminalGroup,
  pattern = "*",
  command = [[
    set ft=terminal
    startinsert
  ]],
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = TerminalGroup,
  pattern = "term://*",
  command = [[startinsert]],
})

vim.api.nvim_create_autocmd("TermClose", {
  group = TerminalGroup,
  pattern = "*",
  command = [[bdelete!]],
})

local StartifyGroup = vim.api.nvim_create_augroup("Startify", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = StartifyGroup,
  pattern = "StartifyReady",
  command = [[cd ~]],
})
