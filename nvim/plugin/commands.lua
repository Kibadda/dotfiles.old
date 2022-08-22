vim.api.nvim_create_user_command("OpenTerminal", function(opts)
  vim.cmd(string.format("term %s", opts.args))
end, {
  bang = true,
  nargs = "?",
  desc = "Open terminal",
  complete = "shellcmd",
})
