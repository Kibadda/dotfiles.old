local M = {
  "Kibadda/session.nvim",
  dev = true,
  lazy = false,
  priority = 1000,
}

M.opts = {
  pre_save_hook = function()
    vim.cmd.Neotree { "close" }
  end,
}

return M
