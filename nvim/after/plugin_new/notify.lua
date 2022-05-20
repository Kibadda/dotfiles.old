if not pcall(require, "notify") then
  return
end

vim.notify = require "notify"
