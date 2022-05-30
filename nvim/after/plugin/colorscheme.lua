if not pcall(require, "colorbuddy") then
  return
end

vim.opt.termguicolors = true

require("colorizer").setup()
require("colorbuddy").colorscheme "onebuddy"
