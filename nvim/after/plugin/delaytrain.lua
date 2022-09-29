if not PluginsOk "delaytrain" then
  return
end

-- Do not ask why
vim.defer_fn(require("delaytrain").setup, 1000)
