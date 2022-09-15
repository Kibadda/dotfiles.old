if true or not PluginsOk "hop" then
  return
end

require("hop").setup {}

RegisterKeymaps {
  mode = "",
  prefix = "",
  {
    f = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        }
      end,
      "Move to next char",
    },
    F = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        }
      end,
      "Move to previous char",
    },
    t = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
      "Move before next char",
    },
    T = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1,
        }
      end,
      "Move before previous char",
    },
  },
}
