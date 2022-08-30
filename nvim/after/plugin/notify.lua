if not CheckPlugin "notify" then
  return
end

vim.notify = require "notify"
