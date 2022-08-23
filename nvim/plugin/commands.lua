vim.api.nvim_create_user_command("OpenTerminal", function(opts)
  vim.cmd(string.format("term %s", opts.args))
end, {
  bang = true,
  nargs = "?",
  desc = "Open terminal",
  complete = "shellcmd",
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

vim.api.nvim_create_user_command("DetachTmux", function ()
  vim.cmd [[!tmux detach]]
end, {
  bang = false,
  nargs = 0,
  desc = "Detach from tmux"
})
