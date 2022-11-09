vim.api.nvim_create_user_command("D", function(argument)
  if argument.bang then
    vim.cmd "bp | bd! #"
  else
    vim.cmd "bp | bd #"
  end
end, {
  bang = true,
  nargs = 0,
  desc = "Bdelete",
})

vim.api.nvim_create_user_command("X", require("user.utils").save_and_source, {
  bang = false,
  nargs = 0,
  desc = "Save and source",
})
