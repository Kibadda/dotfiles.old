vim.api.nvim_create_user_command("OpenTerminal", function(opts)
  vim.cmd(string.format("term %s", opts.args))
end, {
  bang = true,
  nargs = "?",
  desc = "Open terminal",
  complete = "shellcmd",
})

vim.api.nvim_create_user_command("OpenDirectory", function(opts)
  local input = opts.args

  if input == "" then
    input = vim.fn.input("directory: ", "", "dir")
  end

  if vim.fn.isdirectory(input) == 0 then
    vim.notify(string.format("%s is not a directory", input), "warn")
    return
  end

  vim.cmd(string.format("cd %s", input))
  vim.cmd [[term ranger]]
end, {
  bang = true,
  nargs = "?",
  desc = "Open new directory",
  complete = "dir",
})
