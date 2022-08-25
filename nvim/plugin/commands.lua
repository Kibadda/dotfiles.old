local function openTerminal(command)
  vim.cmd(string.format("term %s", command))
end

vim.api.nvim_create_user_command("Lazygit", function()
  openTerminal "lazygit"
end, {
  bang = false,
  nargs = 0,
  desc = "Open lazygit",
})

vim.api.nvim_create_user_command("ToggleAutoFormat", function()
  if vim.g.lsp_auto_format == 0 then
    vim.g.lsp_auto_format = 1
    vim.notify("Turned on", "success", { title = "Auto Format" })
  else
    vim.g.lsp_auto_format = 0
    vim.notify("Turned off", "success", { title = "Auto Format" })
  end
end, {
  bang = false,
  nargs = 0,
  desc = "toggle auto format option",
})

vim.api.nvim_create_user_command("DetachTmux", function()
  vim.cmd [[!tmux detach]]
end, {
  bang = false,
  nargs = 0,
  desc = "Detach from tmux",
})

vim.api.nvim_create_user_command("SaveAndSource", function()
  vim.cmd [[w]]

  if vim.bo.filetype == "lua" then
    vim.cmd [[luafile %]]
  elseif vim.bo.filetype == "vim" then
    vim.cmd [[source %]]
  end
end, {
  bang = false,
  nargs = 0,
  desc = "Save and source current file",
})

vim.cmd [[cabbrev x SaveAndSource]]

vim.cmd [[cabbrev d bd]]
vim.cmd [[cabbrev wd w\|bd]]
vim.cmd [[cabbrev dw w\|bd]]
