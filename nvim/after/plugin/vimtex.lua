local globals = require "user.utils.globals"

if not globals.get("loaded", "vimtex") then
  return
end

globals.set("tex", {
  flavor = "latex",
  conceal = "abdmg",
})

globals.set("vimtex", {
  view_method = "zathura",
  quickfix_mode = 0,
})
