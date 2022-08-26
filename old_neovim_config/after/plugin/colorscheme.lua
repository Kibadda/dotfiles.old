if not pcall(require, "colorbuddy") then
  return
end

vim.opt.termguicolors = true

require("colorizer").setup()
require("colorbuddy").colorscheme "gruvbuddy"

local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("CmpItemKind", g.Special)
Group.new("CmpItemMenu", g.NonText)
Group.new("CmpItemAbbr", g.Comment.fg:light())
Group.new("CmpItemAbbrDeprecated", g.Error)
Group.new("CmpItemAbbrMatchFuzzy", g.Comment, nil, s.italic)
