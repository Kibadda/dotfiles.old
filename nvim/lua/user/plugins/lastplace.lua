local M = {
  "ethanholz/nvim-lastplace",
  event = "VeryLazy",
}

M.opts = {
  lastplace_ignore_buftype = {
    "quickfix",
    "nofile",
    "help",
  },
  lastplace_ignore_filetype = {
    "gitcommit",
    "gitrebase",
  },
}

return M
