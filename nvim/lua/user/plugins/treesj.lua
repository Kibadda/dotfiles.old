local M = {
  "Wansmer/treesj",
  cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      g = {
        J = { "<Cmd>TSJJoin<CR>", "Join Lines" },
        S = { "<Cmd>TSJSplit<CR>", "Split Lines" },
      },
    },
  }
end

function M.opts()
  return {
    use_default_keymaps = false,
    langs = {
      smarty = require("treesj.langs.utils").merge_preset(require "treesj.langs.html", {}),
    },
  }
end

return M
