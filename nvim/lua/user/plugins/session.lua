local M = {
  "Kibadda/session.nvim",
  dev = true,
  lazy = false,
  priority = 1000,
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        S = {
          name = "Session",
          n = {
            function()
              require("session.core").new()
            end,
            "New",
          },
          l = {
            function()
              require("session.telescope").list()
            end,
            "New",
          },
        },
      },
    },
  }
end

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
