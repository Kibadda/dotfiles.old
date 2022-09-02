local function openTerminal(command)
  vim.cmd.term(command)
end

vim.api.nvim_create_user_command("Lazygit", function()
  openTerminal "lazygit"
end, {
  bang = false,
  nargs = 0,
  desc = "Open lazygit",
})

vim.api.nvim_create_user_command("ToggleAutoFormat", function()
  if GetGlobal("lsp", "auto_format") then
    SetGlobal("lsp", {
      auto_format = false,
    })
    vim.notify("Turned off", "success", { title = "Auto Format" })
  else
    SetGlobal("lsp", {
      auto_format = true,
    })
    vim.notify("Turned on", "success", { title = "Auto Format" })
  end
end, {
  bang = false,
  nargs = 0,
  desc = "toggle auto format option",
})

vim.api.nvim_create_user_command("DetachTmux", function()
  os.execute "tmux detach"
end, {
  bang = false,
  nargs = 0,
  desc = "Detach from tmux",
})

vim.api.nvim_create_user_command("SaveAndSource", function()
  vim.cmd.w()

  if vim.bo.filetype == "lua" then
    vim.cmd.luafile "%"
  elseif vim.bo.filetype == "vim" then
    vim.cmd.source "%"
  end
end, {
  bang = false,
  nargs = 0,
  desc = "Save and source current file",
})
