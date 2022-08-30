if not PluginsOk "notify" then
  return
end

vim.notify = require "notify"
