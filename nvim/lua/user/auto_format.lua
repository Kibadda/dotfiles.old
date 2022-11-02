local M = {}

vim.g.LspAutoFormat = vim.g.LspAutoFormat or 0

function M.toggle()
  if vim.g.LspAutoFormat == 0 then
    M.enable()
  else
    M.disable()
  end
end

local function notify(text)
  vim.notify(text, "info", { title = "Auto Format" })
end

function M.enable()
  vim.g.LspAutoFormat = 1
  notify "Turned on"
end

function M.disable()
  vim.g.LspAutoFormat = 0
  notify "Turned off"
end

function M.is_on()
  return vim.g.LspAutoFormat == 1
end

return M
