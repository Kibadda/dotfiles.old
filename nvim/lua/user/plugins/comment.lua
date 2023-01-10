local M = {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
}

function M.config()
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
end

return M
