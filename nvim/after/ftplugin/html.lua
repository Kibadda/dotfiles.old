local ts = SetValue(4, 2)

SetOptionsLocal {
  tabstop = ts,
  shiftwidth = ts,
  formatoptions = vim.opt_local.formatoptions - "o",
}
