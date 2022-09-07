vim.defer_fn(function()
  SetOptionsLocal {
    tabstop = 4,
    shiftwidth = 4,
    formatoptions = GetFormatOptions(vim.opt_local),
  }
end, 100)
