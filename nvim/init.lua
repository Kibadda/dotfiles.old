_ = {
  [======================================[
   _  __ _  _               _     _
  | |/ /(_)| |__   __ _  __| | __| | __ _
  | ' / | || ´_ \ / _` |/ _` |/ _` |/ _` |
  | . \ | || |_) | (_| | (_| | (_| | (_| |
  |_|\_\|_||_⹁__/ \__,_|\__,_|\__,_|\__,_|

  ]======================================],
}

require "user.globals"

if plugins_ok "impatient" then
  require "impatient"
end

if require "user.first_load" then
  return
end

require "user.plugins"

require("user.utils.globals").set("", {
  mapleader = " ",
  formatoptions = "nljqrc",
  notify_about_missing_plugins = true,
})

require "user.disable_builtin"
require "user.options"
require "user.keymaps"
require "user.autocmds"
require "user.abbreviations"
require "user.filetypes"
require "user.commands"
