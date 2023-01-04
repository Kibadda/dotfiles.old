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
require "user.options"

require("user.utils.globals").set("", {
  mapleader = " ",
  formatoptions = "nljqrc",
  notify_about_missing_plugins = false,
})

require "user.lazy"

require "user.keymaps"
require "user.autocmds"
require "user.abbreviations"
require "user.filetypes"
require "user.commands"
