if not PluginsOk "Comment" then
  return
end

require("Comment").setup {
  opleader = {
    line = "gc",
    block = "gb",
  },
  mappings = {
    basic = true,
    extra = true,
  },
  toggler = {
    line = "gcc",
    block = "gbc",
  },
  ignore = "^$",
}

local comment_ft = require "Comment.ft"
comment_ft.set("smarty", { "{*%s*}", "{*%s*}" })
