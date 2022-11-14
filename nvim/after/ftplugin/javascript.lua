local ts = require("user.utils").set_value(4, 2)

require("user.utils.options").set {
  tabstop = ts,
  shiftwidth = ts,
  formatoptions = vim.g.formatoptions,
}
