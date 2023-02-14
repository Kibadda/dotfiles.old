local M = {
  "Kibadda/session.nvim",
  dev = true,
  lazy = false,
  priority = 1000,
}

M.opts = {
  hooks = {
    pre = {
      save = function()
        vim.cmd.Neotree "close"
      end,
    },
  },
}

return M
