-- nvim-cmp highlight groups.
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("CmpItemKind", g.Special)
Group.new("CmpItemMenu", g.NonText)
Group.new("CmpItemAbbr", g.Comment)
Group.new("CmpItemAbbrDeprecated", g.Error)
Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
