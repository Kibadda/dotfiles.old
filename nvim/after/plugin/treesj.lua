if not plugins_ok "treesj" then
  return
end

local tsj_utils = require "treesj.langs.utils"

require("treesj").setup {
  use_default_keymaps = false,
  langs = {
    php = {
      array_creation_expression = tsj_utils.set_preset_for_dict {
        join = {
          space_in_brackets = false,
        },
      },
      arguments = tsj_utils.set_preset_for_args {
        join = {
          space_in_brackets = false,
        },
      },
      formal_parameters = tsj_utils.set_preset_for_args(),
    },
  },
}

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "",
  {
    gJ = { "<Cmd>TSJJoin<CR>", "Join Lines" },
    gS = { "<Cmd>TSJSplit<CR>", "Split Lines" },
  },
}
