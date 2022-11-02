local ts = require("user.utils").set_value(4, 2)

SetBufferOptions {
  tabstop = ts,
  shiftwidth = ts,
  formatoptions = vim.g.formatoptions,
}
