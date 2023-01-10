local M = {
  "Wansmer/treesj",
}

function M.config()
  require("treesj").setup {
    use_default_keymaps = false,
    langs = {
      smarty = require("treesj.langs.utils").merge_preset(require "treesj.langs.html", {}),
    },
  }

  require("user.utils.register").keymaps {
    n = {
      g = {
        J = { "<Cmd>TSJJoin<CR>", "Join Lines" },
        S = { "<Cmd>TSJSplit<CR>", "Split Lines" },
      },
    },
  }
end

return M
