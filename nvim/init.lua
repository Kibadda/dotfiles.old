_ = {
  [======================================[
   _  __ _  _               _     _
  | |/ /(_)| |__   __ _  __| | __| | __ _
  | ' / | || ´_ \ / _` |/ _` |/ _` |/ _` |
  | . \ | || |_) | (_| | (_| | (_| | (_| |
  |_|\_\|_||_⹁__/ \__,_|\__,_|\__,_|\__,_|

  ]======================================],
}

require "impatient"

require "user.globals"

if require "user.first_load" then
  return
end

SetGlobal("", {
  mapleader = " ",
  formatoptions = "nljqrc",
})

require "user.disable_builtin"
require "user.options"
require "user.plugins"
require "user.keymaps"
require "user.autocmds"
require "user.abbreviations"
