local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  lazy = false,
  enabled = false,
}

function M.init() end

function M.config()
  require("user.utils.options").set {
    foldcolumn = "1",
    foldlevel = 99,
    foldlevelstart = 99,
    foldenable = true,
  }

  require("ufo").setup {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  }
end

return M
