local M = {
  "ThePrimeagen/refactoring.nvim",
  config = true,
}

function M.init()
  require("user.utils.register").keymaps {
    x = {
      ["<Leader>"] = {
        r = { ":lua require('refactoring').select_refactor()<CR>", "Refactor" },
      },
    },
  }
end

return M
