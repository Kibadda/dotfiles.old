local ts = SetValue(4, 2)

SetOptionsLocal {
  tabstop = ts,
  shiftwidth = ts,
  formatoptions = GetFormatOptions(vim.opt_local),
}
