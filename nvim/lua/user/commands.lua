vim.api.nvim_create_user_command("D", function(argument)
  vim.cmd.bp()
  if vim.fn.expand("#"):sub(1, 8) ~= "fugitive" then
    if argument.bang then
      vim.cmd "sp|bn|bd!"
    else
      vim.cmd "sp|bn|bd"
    end
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
