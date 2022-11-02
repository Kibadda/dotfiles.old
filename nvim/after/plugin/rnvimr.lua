local globals = require "user.utils.globals"

if not globals.get("loaded", "rnvimr") then
  return
end

globals.set("rnvimr", {
  vanilla = true,
  enable_ex = true,
  enable_picker = true,
  hide_gitignore = true,
  border_attr = {
    fg = 14,
    bg = -1,
  },
  enable_bw = true,
  ranger_cmd = {
    "ranger",
    "--cmd=set draw_borders both",
  },
})

require("user.utils").register_keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    e = { "<Cmd>RnvimrToggle<CR>", "Browse Files" },
  },
}
