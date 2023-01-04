local M = {
  "ethanholz/nvim-lastplace",
}

function M.config()
  require("nvim-lastplace").setup {
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
end

return M
