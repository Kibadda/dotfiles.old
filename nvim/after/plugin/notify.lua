if not PluginsOk "notify" then
  return
end

require("notify").setup {
  stages = "fade",
  render = "simple",
}

vim.notify = require "notify"
