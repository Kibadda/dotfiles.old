local function toggle_spellings()
  if vim.api.nvim_get_option_value("spell", { scope = "global" }) then
    vim.opt.spell = false
    vim.notify("spellings deactivated", "info", { render = "minimal" })
  else
    vim.opt.spell = true
    vim.notify("spellings activated", "info", { render = "minimal" })
  end
end

vim.keymap.set("n", "<Leader>ts", toggle_spellings, { desc = "Toggle spelling" })
vim.api.nvim_create_user_command("ToggleSpelling", toggle_spellings, { nargs = 0, desc = "Toggle spelling" })
